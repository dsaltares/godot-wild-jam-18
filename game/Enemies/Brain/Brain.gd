extends KinematicBody2D
class_name Brain

signal shake_requested

enum State {
	Idle,
	Attack,
	Die
}

onready var Bullet := preload("res://Bullet/EnemyBullet.tscn")
onready var animation_player := $AnimationPlayer
onready var pivot := $Pivot
onready var detection_area := $DetectionArea
onready var line_of_sight := $LineOfSight
onready var attack_cooldown := $AttackCooldown
onready var attack_area := $AttackArea
onready var bullet_spawner := $Pivot/BulletSpawner
onready var damage_area := $DamageArea

var target : Player
var state = State.Idle
var has_line_of_sight := false

func _ready() -> void:
	animation_player.play("idle")
	animation_player.connect("animation_finished", self, "on_AnimationPlayer_animation_finished")
	detection_area.connect("body_entered", self, "on_DetectionArea_body_entered")
	detection_area.connect("body_exited", self, "on_DetectionArea_body_exited")

func _physics_process(delta: float) -> void:
	_look_at_target()
	_update_line_of_sight()
	_update_attack()
	_update_damage_area()

func take_damage() -> void:
	emit_signal("shake_requested")
	animation_player.play("die")

func on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "die":
		queue_free()
	elif name == "attack":
		finish_attack()

func on_DetectionArea_body_entered(body: Node) -> void:
	if not body is Player:
		return
		
	target = body as Player

func on_DetectionArea_body_exited(body: Node) -> void:
	if target == body:
		target = null
		
func _look_at_target() -> void:
	if not target:
		return
	
	pivot.scale.x = 1 if target.global_position.x > global_position.x else -1

func _update_line_of_sight() -> void:
	if not target:
		return
	var target_pos = target.global_position
	var to_target = target_pos - line_of_sight.global_position
	var to_target_dir = to_target.normalized()
	var to_target_distance = to_target.length()
	line_of_sight.cast_to = to_target_dir * (to_target_distance + 2)
	line_of_sight.force_raycast_update()

	var collider = line_of_sight.get_collider()
	has_line_of_sight = collider == target
	
func _update_attack() -> void:
	var can_attack = \
		state == State.Idle and \
		has_line_of_sight and \
		target != null and \
		attack_cooldown.time_left == 0 and \
		attack_area.overlaps_body(target)
	
	if not can_attack:
		return
	
	state = State.Attack
	animation_player.play("attack")
			

func _update_damage_area() -> void:
	var bodies = damage_area.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage()

func shoot() -> void:
	if not target:
		finish_attack()
		return
		
	var target_pos = target.global_position
	var to_target = target_pos - line_of_sight.global_position
	var to_target_dir = to_target.normalized()
	
	var bullet = Bullet.instance()
	bullet.direction = to_target_dir
	bullet.global_position = bullet_spawner.global_position
	get_tree().get_root().add_child(bullet)

func finish_attack():
	state = State.Idle
	animation_player.play("idle")
	attack_cooldown.start()
