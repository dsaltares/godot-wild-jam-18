extends PlayerState
class_name Air

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)
	
	if event.is_action_pressed("dash") and not _parent.is_dashing:
		animation_player.play("dash")
		_parent.is_dashing = true
		player.get_sfx("Dash").play()

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	
	if not _parent.is_dashing:
		if _parent.velocity.y < 0:
			animation_player.play("jump")
		else:
			animation_player.play("jump_air")
		
	if player.is_on_floor():
		player.get_sfx("Land").play()
		_state_machine.transition_to('Move/Idle')
		
