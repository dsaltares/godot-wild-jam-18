extends State
class_name PlayerState

var player: KinematicBody2D
var animation_player: AnimationPlayer
var bullet_spawner: Position2D
var pivot: Position2D
var attack_area: Area2D

func _ready() -> void:
	yield(owner, 'ready')
	player = owner
	animation_player = owner.animation_player
	bullet_spawner = owner.bullet_spawner
	pivot = owner.pivot
	attack_area = owner.attack_area
