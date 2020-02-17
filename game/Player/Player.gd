extends KinematicBody2D
class_name Player

signal health_changed
signal damaged
signal ammo_changed

onready var state_machine: StateMachine = $StateMachine
onready var animation_player := $AnimationPlayer
onready var bullet_spawner := $Pivot/BulletSpawner
onready var pivot := $Pivot
onready var attack_area := $Pivot/AttackArea
onready var effect_player := $EffectPlayer

const MAX_HEALTH = 5
const MAX_AMMO = 26

var health = MAX_HEALTH
var ammo = 5
var taking_damage = false

func _ready() -> void:
	effect_player.connect("animation_finished", self, "on_EffectPlayer_animation_finished")

func _physics_process(delta: float) -> void:
	animation_player.advance(delta)

func take_damage(damage : int = 1) -> void:
	if taking_damage:
		return
		
	health = max(health - damage, 0)
	taking_damage = true
	effect_player.play("damage")
	emit_signal("damaged")
	emit_signal("health_changed", health)

func can_shoot() -> bool:
	return ammo > 0

func pickup_ammo(amount: int) -> void:
	ammo = min(ammo + amount, MAX_AMMO)

func shoot() -> bool:
	if ammo <= 0:
		return false
	
	ammo -= 1
	emit_signal("ammo_changed", ammo)
	return true
	

func on_EffectPlayer_animation_finished(name: String) -> void:
	if name == "damage":
		taking_damage = false
