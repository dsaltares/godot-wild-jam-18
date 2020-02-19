extends Node2D


onready var camera := $Camera


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shake"):
		camera.shake()
