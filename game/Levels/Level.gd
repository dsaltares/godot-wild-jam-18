extends Node2D

class_name Level

signal player_enter

func _on_Level_entered(body):
	if body.name == "Player":
		emit_signal("player_enter", self)
