extends PlayerState
class_name Air

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		_state_machine.transition_to('Move/Idle')

func enter(msg: = {}) -> void:
	if _parent.velocity.y < 0:
		playback.travel('jump')
	else:
		playback.travel("jump_air")


