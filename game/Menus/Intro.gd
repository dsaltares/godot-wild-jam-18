extends Node2D
class_name IntroScreen

signal done

onready var player_anim := $GameScene/Player/AnimationPlayer
onready var skull_anim := $GameScene/Skull/AnimationPlayer
onready var darklord_anim := $GameScene/Darklord/AnimationPlayer

onready var animation_player := $AnimationPlayer
onready var key_sfx := $PressKey
onready var welcome_voice := $Welcome

var skipped = false

func _ready() -> void:
	player_anim.play("idle")
	skull_anim.play("idle")
	darklord_anim.play("idle")
	welcome_voice.play()

func _input(event):
	var is_key = event is InputEventKey and event.is_pressed()
	var is_mouse = event is InputEventMouseButton and event.is_pressed()
	var is_skip_event = is_key or is_mouse
	var is_anim_done = animation_player.current_animation == "idle"
	if not skipped and is_skip_event and is_anim_done:
		emit_signal("done")
		key_sfx.play()
		skipped = true

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "intro":
		animation_player.play("idle")
