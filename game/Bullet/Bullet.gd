extends KinematicBody2D
class_name Bullet

export var SPEED := 275

var direction := 1

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite

func _ready() -> void:
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	sprite.flip_h = direction < 0
	var collision := move_and_collide(Vector2(SPEED * direction * delta, 0))
	
	if collision == null or not (collision.collider is Node):
		return
	
	var collider := collision.collider as Node
	
	if collider.is_in_group("enemies"):
		collider.take_damage()
	
	animation_player.play("hit")
