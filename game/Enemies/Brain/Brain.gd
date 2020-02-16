extends KinematicBody2D
class_name Brain

onready var animation_player := $AnimationPlayer
onready var pivot := $Pivot
onready var detection_area := $DetectionArea

func _ready() -> void:
	animation_player.play("idle")
	animation_player.connect("animation_finished", self, "on_AnimationPlayer_animation_finished")
	
func _exit_tree() -> void:
	animation_player.disconnect("animation_finished", self, "on_AnimationPlayer_animation_finished")

func take_damage() -> void:
	animation_player.play("die")

func on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "die":
		queue_free()
