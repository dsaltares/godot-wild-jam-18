extends KinematicBody2D
class_name Player


onready var sprite := $Sprite
onready var state_machine: StateMachine = $StateMachine
onready var playback : AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _ready() -> void:
	$AnimationTree.active = true
