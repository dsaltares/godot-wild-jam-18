extends KinematicBody2D

enum State {
	Walk,
	Attack,
	Die
}

const MAX_SPEED = 70
const ATTACK_DASH_SPEED = 150
const GRAVITY = 1000

onready var animation_player := $AnimationPlayer
onready var pivot := $Pivot
onready var floor_raycast := $Pivot/FloorRayCast

var state = State.Walk
var direction := -1
var velocity := Vector2.ZERO

func take_damage() -> void:
	state = State.Die
	animation_player.play("die")

func _ready() -> void:
	animation_player.play("walk")
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _exit_tree() -> void:
	animation_player.disconnect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _physics_process(delta: float) -> void:
	_update_vertical_velocity(delta)
	_update_horizontal_velocity(delta)
	_move(delta)
	_update_pivot()

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "die":
		queue_free()

func _update_pivot() -> void:
	pivot.scale.x = direction

func _update_vertical_velocity(delta: float) -> void:
	if is_on_floor():
		velocity.y = 5
	else:
		velocity.y += GRAVITY * delta
		
func _update_horizontal_velocity(delta: float) -> void:
	if state == State.Walk and not is_on_wall():
		velocity.x = MAX_SPEED * direction
	else:
		velocity.x = 0
		
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
	var on_wall = is_on_wall()
	var no_floor_ahead = not floor_raycast.is_colliding()
	var should_turn = on_wall or no_floor_ahead
	
	if should_turn:
		direction *= -1
	
