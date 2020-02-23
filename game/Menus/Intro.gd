extends Node2D
class_name IntroScreen

signal done

onready var player_anim := $GameScene/Player/AnimationPlayer
onready var skull_anim := $GameScene/Skull/AnimationPlayer
onready var darklord_anim := $GameScene/Darklord/AnimationPlayer

onready var animation_player := $AnimationPlayer
onready var key_sfx := $PressKey
onready var keyboard_controls := $UI/Controls/Keyboard
onready var gamepad_controls := $UI/Controls/Gamepad
onready var ps4_buttons := $UI/Controls/Gamepad/PS4
onready var xbox_buttons := $UI/Controls/Gamepad/XBOX

var skipped = false

func _ready() -> void:
	player_anim.play("idle")
	skull_anim.play("idle")
	darklord_anim.play("idle")
	
	var has_joypad := Input.get_connected_joypads().size() > 0
	if has_joypad:
		keyboard_controls.visible = false
		gamepad_controls.visible = true
		if is_dualshock():
			ps4_buttons.visible = true
			xbox_buttons.visible = false
		else:
			ps4_buttons.visible = false
			xbox_buttons.visible = true
	else:
		keyboard_controls.visible = true
		gamepad_controls.visible = false

func _input(event):
	var is_key = event is InputEventKey and event.is_pressed()
	var is_button = event is InputEventJoypadButton and event.is_pressed()
	var is_mouse = event is InputEventMouseButton and event.is_pressed()
	var is_skip_event = is_key or is_mouse or is_button
	var is_anim_done = animation_player.current_animation == "idle"
	if not skipped and is_skip_event and is_anim_done:
		emit_signal("done")
		key_sfx.play()
		skipped = true

func _on_AnimationPlayer_animation_finished(name: String) -> void:
	if name == "intro":
		animation_player.play("idle")

func is_dualshock() -> bool:
	var joypad_name = Input.get_joy_name(0).to_lower()
	var names = [
		"dualshock",
		"ps4",
		"sony",
		"playstation"
	]
	for name in names:
		if joypad_name.find(name) != -1:
			return true
	return false
