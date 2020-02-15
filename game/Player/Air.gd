extends PlayerState
class_name Air

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	
	if _parent.velocity.y < 0:
		animation_player.play("jump")
	else:
		animation_player.play("jump_air")
		
	if player.is_on_floor():
		_state_machine.transition_to('Move/Idle')
