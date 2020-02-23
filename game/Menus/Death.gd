extends Node2D
class_name DeathScreen

signal done

onready var animation_player := $AnimationPlayer
onready var final_score_label := $UI/FinalScore
onready var voice := $YouAreDead
onready var key_sfx := $PressKey

var skipped = false
var final_score: int = 0

func _ready() -> void:
	var pluralized_points = "points" if final_score != 0 else "point"
	final_score_label.text = "Final score: %s %s" % [final_score, pluralized_points]
	voice.play()

func _input(event):
	var is_key = event is InputEventKey and event.is_pressed()
	var is_mouse = event is InputEventMouseButton and event.is_pressed()
	var is_skip_event = is_key or is_mouse
	var is_anim_done = animation_player.current_animation == "idle"
	if not skipped and is_skip_event and is_anim_done:
		emit_signal('done')
		key_sfx.play()
		skipped = true

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "intro":
		animation_player.play("idle")

