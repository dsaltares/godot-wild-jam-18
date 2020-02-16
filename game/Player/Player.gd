extends KinematicBody2D
class_name Player


onready var sprite := $Pivot/Sprite
onready var state_machine: StateMachine = $StateMachine
onready var animation_player := $AnimationPlayer
onready var bullet_spawner := $Pivot/BulletSpawner
onready var pivot := $Pivot

func _physics_process(delta: float) -> void:
	animation_player.advance(delta)
