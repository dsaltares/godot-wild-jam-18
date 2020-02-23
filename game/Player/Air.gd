extends PlayerState
class_name Air

const COYOYE_TIME := .1

func enter(_msg := {}) -> void:
	_parent.enter()
	_coyote_time()

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
		_parent.can_jump = true
		player.land_particles.emitting = true
		player.get_sfx("Land").play()
		_state_machine.transition_to('Move/Idle')
		
func _coyote_time() -> void:
	yield(get_tree().create_timer(COYOYE_TIME), "timeout")
	if not player.is_on_floor() and _parent.can_jump:
		_parent.can_jump = false
