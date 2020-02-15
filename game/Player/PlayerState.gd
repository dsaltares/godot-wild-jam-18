extends State
class_name PlayerState

var player: KinematicBody2D
var sprite: Sprite
var animation_player: AnimationPlayer

func _ready() -> void:
	yield(owner, 'ready')
	player = owner
	sprite = owner.sprite

	animation_player = owner.animation_player
