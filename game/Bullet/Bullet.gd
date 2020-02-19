extends KinematicBody2D
class_name Bullet

signal shake_requested

enum State {
	Travel,
	Hit
}

export var SPEED := 350

var direction := Vector2.RIGHT
var state = State.Travel

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite
onready var damage_area := $DamageArea

func _ready() -> void:
	animation_player.play("idle")
	damage_area.connect("body_entered", self, "on_DamageArea_body_entered")

func _physics_process(delta: float) -> void:
	if state == State.Hit:
		return
		
	sprite.rotation = direction.angle()
	var collision := move_and_collide(direction * SPEED * delta)
	
	if collision:
		emit_signal("shake_requested")
		hit()
	
func on_DamageArea_body_entered(body: Node) -> void:
	hit(body)

func hit(node: Node = null) -> void:
	if node and node.has_method("take_damage"):
		node.take_damage()
	state = State.Hit
	animation_player.play("hit")
