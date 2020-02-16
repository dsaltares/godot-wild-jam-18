extends PlayerState
class_name Attack

func enter(msg: = {}) -> void:
	animation_player.connect("animation_finished", self, "on_animation_player_on_animation_finished")
	attack_area.connect("body_entered", self, "on_attack_area_body_entered")
	animation_player.play('attack')

func exit() -> void:
	animation_player.disconnect("animation_finished", self, "on_animation_player_on_animation_finished")
	attack_area.disconnect("body_entered", self, "on_attack_area_body_entered")

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	_update_animation()
	
func _update_animation() -> void:
	var running : bool = player.is_on_floor() and _parent.move_dir
	var animation := 'attack_run' if running else 'attack'
	if animation != animation_player.current_animation:
		var current_position = animation_player.current_animation_position
		animation_player.play(animation)
		animation_player.advance(current_position)
		
func on_animation_player_on_animation_finished(name: String) -> void:
	if name == 'attack_run' or name == 'attack':
		_state_machine.transition_to('Move/Idle')

func on_attack_area_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		body.take_damage()
