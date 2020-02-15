extends PlayerState
class_name Idle

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.move_dir:
		_state_machine.transition_to('Move/Run')
	elif not player.is_on_floor():
		_state_machine.transition_to('Move/Air')

func enter(msg: = {}) -> void:
	animation_player.play("idle")
