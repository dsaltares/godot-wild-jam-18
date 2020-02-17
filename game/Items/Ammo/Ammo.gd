extends Area2D
class_name Ammo

export var amount := 4

onready var animation_player = $AnimationPlayer

func _ready() -> void:
	self.connect("body_entered", self, "on_Ammo_body_entered")
	animation_player.play("idle")
	
func on_Ammo_body_entered(body: Node) -> void:
	var player := body as Player
	if not player:
		return
	player.pickup_ammo(amount)
	queue_free()
