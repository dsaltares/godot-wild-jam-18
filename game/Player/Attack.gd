extends PlayerState
class_name Attack

func enter(msg: = {}) -> void:
	animation_player.connect("animation_finished", self, "animation_player_on_animation_finished")
	animation_player.play('attack')

func exit() -> void:
	animation_player.disconnect("animation_finished", self, "animation_player_on_animation_finished")

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
		
func animation_player_on_animation_finished(name: String) -> void:
	if name == 'attack_run' or name == 'attack':
		_state_machine.transition_to('Move/Idle')
