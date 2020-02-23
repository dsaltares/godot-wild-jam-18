extends KinematicBody2D
class_name Darklord

signal shake_requested


enum State {
	Walk,
	Attack,
	Die
}

const WALK_SPEED = 50
const ATTACK_DASH_SPEED = 250
const GRAVITY = 1000

onready var animation_player := $AnimationPlayer
onready var effect_player := $EffectPlayer
onready var pivot := $Pivot
onready var floor_raycast := $Pivot/FloorAheadRayCast
onready var floor_behind_raycast := $Pivot/FloorBehindRayCast
onready var wall_ahead_raycast := $Pivot/WallAheadRayCast
onready var wall_behind_raycast := $Pivot/WallBehindRayCast
onready var player_raycast := $Pivot/PlayerRayCast
onready var attack_cooldown := $AttackCooldown
onready var damage_area := $DamageArea

export var dash_enabled := false

var health = 3
# The player gets points on every hit, so total score = health*points
var points = 200 
var state = State.Walk
var direction := -1
var velocity := Vector2.ZERO

func take_damage() -> bool:
	if state == State.Die or effect_player.current_animation == "damage":
		return false
	
	if health == 1:
		emit_signal("shake_requested")
		state = State.Die
		animation_player.play("die")
		return true
	else:
		health -= 1
		effect_player.play("damage")
		return true

func _ready() -> void:
	animation_player.play("walk")
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _exit_tree() -> void:
	animation_player.disconnect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _physics_process(delta: float) -> void:
	_update_vertical_velocity(delta)
	_update_horizontal_velocity(delta)
	_update_player_detection()
	_move(delta)
	_update_direction()
	_update_pivot()
	_update_damage_area()

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "die":
		queue_free()
	if name == "attack":
		state = State.Walk
		animation_player.play("walk")

func _update_pivot() -> void:
	pivot.scale.x = direction

func _update_vertical_velocity(delta: float) -> void:
	if is_on_floor():
		velocity.y = 5
	else:
		velocity.y += GRAVITY * delta
		
func _update_horizontal_velocity(delta: float) -> void:
	velocity.x = 0
	
	if state == State.Die:
		return
		
	var moving = state == State.Walk
	var space_ahead = not is_on_wall()
	var attack_dash = dash_enabled and State.Attack
	var can_move = (moving or attack_dash) and space_ahead
	if can_move:
		var horizontal_speed = ATTACK_DASH_SPEED if state == State.Attack else WALK_SPEED
		velocity.x = horizontal_speed * direction
		
func _update_player_detection() -> void:
	if state != State.Walk:
		return
	
	var detects_player = player_raycast.is_colliding()
	var can_attack = attack_cooldown.time_left == 0
	if detects_player and can_attack:
		state = State.Attack
		animation_player.play("attack")
		attack_cooldown.start()
		
func _move(delta: float) -> void:
	var snap := Vector2.DOWN * 0.01
	var floor_normal := Vector2.UP
	var stop_on_slope := true
	var max_slides := 4
	var max_slope := deg2rad(25)
	var infinite_inertia := true
	
	move_and_slide_with_snap(
		velocity,
		snap,
		Vector2.UP,
		stop_on_slope,
		max_slides,
		max_slope,
		infinite_inertia
	)
	
func _update_direction() -> void:
	if state != State.Walk:
		return
	
	var floor_ahead = floor_raycast.is_colliding()
	var floor_behind = floor_behind_raycast.is_colliding()
	var wall_ahead = wall_ahead_raycast.is_colliding()
	var wall_behind = wall_behind_raycast.is_colliding()
	
	var should_turn = false
	
	if wall_ahead:
		should_turn = true
	
	if not floor_ahead and floor_behind and not wall_behind:
		should_turn = true
	
	if should_turn:
		direction *= -1

	
func _update_damage_area() -> void:
	if state == State.Die or effect_player.current_animation == "damage":
		return 
		
	var bodies = damage_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage()

