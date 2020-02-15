extends PlayerState
class_name Move

const MAX_HORIZONTAL_SPEED := 150
const MAX_FALLING_SPEED := 500
const TIME_TO_MAX_SPEED := 0.1
const JUMP_HEIGHT := 40
const DISTANCE_TO_PEAK := 70
const DISTANCE_AFTER_PEAK := 40

var move_dir := 0
var gravity := 0
var velocity = Vector2.ZERO

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		_state_machine.transition_to("Move/Shoot")
	if event.is_action_pressed("attack"):
		_state_machine.transition_to("Move/Attack")

func physics_process(delta: float) -> void:
	_update_horizontal_velocity(delta)
	_update_vertical_velocity(delta)
	_update_look_dir()
	_move(delta)

func _update_horizontal_velocity(delta):
	move_dir = 0
	if Input.is_action_pressed("left"):
		move_dir = -1
	elif Input.is_action_pressed("right"):
		move_dir = 1
	
	if move_dir != 0:
		velocity.x += move_dir * (MAX_HORIZONTAL_SPEED/TIME_TO_MAX_SPEED) * delta
		velocity.x = clamp(velocity.x, -MAX_HORIZONTAL_SPEED, MAX_HORIZONTAL_SPEED)
	else:
		var prev_move_dir = sign(velocity.x)
		var min_speed = 0 if prev_move_dir > 0 else velocity.x
		var max_speed = velocity.x if prev_move_dir > 0 else 0
		velocity.x -= prev_move_dir * (MAX_HORIZONTAL_SPEED/TIME_TO_MAX_SPEED) * delta
		velocity.x = clamp(velocity.x, min_speed, max_speed)
		
	if player.is_on_wall():
		velocity.x = 0
		
func _update_vertical_velocity(delta):
	if player.is_on_ceiling():
		velocity.y = -0.1
	
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		var jump_speed = -2 * JUMP_HEIGHT * MAX_HORIZONTAL_SPEED / DISTANCE_TO_PEAK
		velocity.y = jump_speed
	elif not player.is_on_floor():
		var jump_section_distance = DISTANCE_TO_PEAK if velocity.y < -0.1 else DISTANCE_AFTER_PEAK
		gravity = 2 * JUMP_HEIGHT * pow(MAX_HORIZONTAL_SPEED, 2) / pow(jump_section_distance, 2)
		velocity.y += gravity * delta
	else:
		velocity.y = 5
		
	velocity.y = min(velocity.y, MAX_FALLING_SPEED)

func _update_look_dir() -> void:
	if move_dir:
		sprite.flip_h = move_dir < 0
		

func _move(delta):
	var snap := Vector2.DOWN * 0.01
	var floor_normal := Vector2.UP
	var stop_on_slope := true
	var max_slides := 4
	var max_slope := deg2rad(25)
	var infinite_inertia := true
	
	player.move_and_slide_with_snap(
		velocity,
		snap,
		Vector2.UP,
		stop_on_slope,
		max_slides,
		max_slope,
		infinite_inertia
	)
