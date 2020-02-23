extends CPUParticles2D

const FADE_TIME = 1

onready var sfx := $SFX
onready var tween := $Tween

func _ready() -> void:
	emitting = false
	sfx.play()
	
func enable() -> void:
	emitting = true
	_fade_in_sfx()
	
func disable() -> void:
	emitting = false
	_fade_out_sfx()

func _fade_in_sfx() -> void:
	tween.interpolate_property(
		sfx,
		"volume_db",
		sfx.volume_db,
		0,
		FADE_TIME,
		Tween.TRANS_QUAD,
		Tween.EASE_IN
	)
	tween.start()
	
func _fade_out_sfx() -> void:
	tween.interpolate_property(
		sfx,
		"volume_db",
		sfx.volume_db,
		-80,
		FADE_TIME,
		Tween.TRANS_QUAD,
		Tween.EASE_IN
	)
	tween.start()
