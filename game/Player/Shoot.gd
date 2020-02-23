extends PlayerState
class_name Shoot

onready var Bullet := preload("res://Bullet/bullet.tscn")

func enter(msg: = {}) -> void:
	animation_player.connect("animation_finished", self, "animation_player_on_animation_finished")
	animation_player.play('shoot')

func exit() -> void:
	animation_player.disconnect("animation_finished", self, "animation_player_on_animation_finished")

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	_update_animation()
	
func _update_animation() -> void:
	var running : bool = player.is_on_floor() and _parent.move_dir
	var animation := 'shoot_run' if running else 'shoot'
	if animation != animation_player.current_animation:
		var current_position = animation_player.current_animation_position
		animation_player.play(animation)
		animation_player.advance(current_position)
		

func animation_player_on_animation_finished(name: String) -> void:
	if name == 'shoot_run' or name == 'shoot':
		_state_machine.transition_to('Move/Idle')

func shoot() -> void:
	var can_shoot = player.shoot()
	if can_shoot:
		var bullet = Bullet.instance()
		bullet.shooter = player
		bullet.direction = Vector2(_parent.direction, 0)
		bullet.global_position = bullet_spawner.global_position
		get_tree().get_root().add_child(bullet)
