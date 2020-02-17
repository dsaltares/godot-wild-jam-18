extends StaticBody2D

onready var Player := preload("res://Player/player.tscn")
onready var spawn_point := $SpawnPoint
onready var animation_player := $AnimationPlayer


func _ready() -> void:
	animation_player.play("spawn")
	animation_player.connect("animation_finished", self, "on_AnimationPlayer_animation_finished")


func on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "spawn":
		animation_player.play("after_spawn")
		
func spawn_player() -> void:
	var player = Player.instance()
	get_tree().get_root().add_child(player)
	player.global_position = spawn_point.global_position
