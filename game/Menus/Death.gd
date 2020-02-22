extends Node2D
class_name DeathScreen

signal done

onready var animation_player := $AnimationPlayer

var skipped = false

func _input(event):
	var is_key = event is InputEventKey and event.is_pressed()
	var is_mouse = event is InputEventMouseButton and event.is_pressed()
	var is_skip_event = is_key or is_mouse
	if not skipped and is_skip_event :
		emit_signal('done')
		skipped = true

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "intro":
		animation_player.play("idle")

