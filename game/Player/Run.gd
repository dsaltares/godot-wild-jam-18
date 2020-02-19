extends PlayerState
class_name Run


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
	if event.is_action_pressed("dash") and not _parent.is_dashing:
		animation_player.play("dash")
		_parent.is_dashing = true
		player.get_sfx("Dash").play()

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor():
		if not _parent.move_dir:
			_state_machine.transition_to('Move/Idle')
	else:
		_state_machine.transition_to('Move/Air')
	
	if not _parent.is_dashing:
		animation_player.play("run")
	
