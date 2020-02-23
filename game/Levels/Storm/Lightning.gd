extends Node2D

const TRANS := Tween.TRANS_SINE
const EASE := Tween.EASE_IN_OUT

onready var sprite := $Sprite
onready var tween := $Tween
onready var frequency_timer := $Frequency
onready var duration_timer := $Duration
onready var thunder_sfx := $SFX

func _ready() -> void:
	frequency_timer.connect("timeout", self, "_on_Frequency_timeout")
	duration_timer.connect("timeout", self, "_on_Duration_timeout")

func strike() -> void:
	duration_timer.start()
	frequency_timer.start()
	_play_random_thunder_sound()
	_new_lightning()

func _on_Frequency_timeout() -> void:
	_new_lightning()
	
func _on_Duration_timeout() -> void:
	_reset()
	frequency_timer.stop()

func _new_lightning() -> void:
	var target_alpha = 0 if sprite.modulate.a > 0 else 0.7
	tween.interpolate_property(
		sprite,
		"modulate",
		sprite.modulate,
		Color(1, 1, 1, target_alpha),
		frequency_timer.wait_time,
		TRANS,
		EASE
	)
	tween.start()
	
func _reset() -> void:
	tween.interpolate_property(
		sprite,
		"modulate",
		sprite.modulate,
		Color(1, 1, 1, 0),
		frequency_timer.wait_time,
		TRANS,
		EASE
	)
	tween.start()

func _play_random_thunder_sound() -> void:
	if thunder_sfx.get_child_count() == 0:
		return
	
	var random_idx = randi() % thunder_sfx.get_child_count()
	var sfx = thunder_sfx.get_child(random_idx) as AudioStreamPlayer
	sfx.play()
