extends Camera2D
class_name GameCamera

const TRANS := Tween.TRANS_SINE
const EASE := Tween.EASE_IN_OUT

var player
var camera_dimensions: Vector2
var amplitude := 0.0
onready var shake_tween := $Shake
onready var frequency_timer := $Frequency
onready var duration_timer := $Duration

func _ready():
	camera_dimensions = get_viewport().size * zoom
	frequency_timer.connect("timeout", self, "_on_Frequency_timeout")
	duration_timer.connect("timeout", self, "_on_Duration_timeout")

func _process(delta):
	if !is_instance_valid(player):
		player = get_tree().get_root().find_node("Player", true, false)
		return
	
	if player.position.x > position.x:
		position.x = player.position.x
	
	_connect_to_shakers()

func _start_shake(duration, amplitude, frequency) -> void:
	self.amplitude = amplitude
	duration_timer.wait_time = duration
	frequency_timer.wait_time = 1 / float(frequency)
	duration_timer.start()
	frequency_timer.start()
	_new_shake()

func _on_Frequency_timeout() -> void:
	_new_shake()
	
func _on_Duration_timeout() -> void:
	_reset()
	frequency_timer.stop()

func _new_shake() -> void:
	var half_amplitude := amplitude / 2.0
	var random_shake := Vector2(
		rand_range(-half_amplitude, half_amplitude),
		rand_range(-half_amplitude, half_amplitude)
	)
	shake_tween.interpolate_property(
		self,
		"offset",
		self.offset,
		random_shake,
		frequency_timer.wait_time,
		TRANS,
		EASE
	)
	shake_tween.start()
	
func _reset() -> void:
	shake_tween.interpolate_property(
		self,
		"offset",
		self.offset,
		Vector2.ZERO,
		frequency_timer.wait_time,
		TRANS,
		EASE
	)
	shake_tween.start()

func _connect_to_shakers():
	for shaker in get_tree().get_nodes_in_group('camera_shakers'):
		if not shaker.is_connected("shake_requested", self, "_on_shaker_shake_requested"):
			shaker.connect('shake_requested', self, '_on_shaker_shake_requested')

func _on_shaker_shake_requested(duration := 0.2, amplitude := 5, frequency := 30) -> void:
	_start_shake(duration, amplitude, frequency)
