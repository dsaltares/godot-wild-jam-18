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
		
	if not _parent.is_dashing:
		animation_player.play("idle")


func _update_horizontal_velocity(delta):	
	var prev_move_dir = sign(_parent.velocity.x)
	var min_speed = 0 if prev_move_dir > 0 else _parent.velocity.x
	var max_speed = _parent.velocity.x if prev_move_dir > 0 else 0
	_parent.velocity.x -= prev_move_dir * (_parent.MAX_HORIZONTAL_SPEED/_parent.TIME_TO_MAX_SPEED) * delta
	_parent.velocity.x = clamp(_parent.velocity.x, min_speed, max_speed)
