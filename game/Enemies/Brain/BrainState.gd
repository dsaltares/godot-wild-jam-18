extends State
class_name BrainState


var brain: KinematicBody2D
var animation_player: AnimationPlayer
var pivot: Position2D
var detection_area: Area2D

func _ready() -> void:
	yield(owner, 'ready')
	brain = owner
	animation_player = owner.animation_player
	pivot = owner.pivot
	detection_area = owner.detection_area
