extends PlayerState
class_name Run

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		if not _parent.move_dir:
			_state_machine.transition_to('Move/Idle')
	else:
		_state_machine.transition_to('Move/Air')

func enter(msg: = {}) -> void:
	playback.travel('')
	_parent.enter(msg)

