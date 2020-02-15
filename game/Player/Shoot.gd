extends PlayerState
class_name Shoot

func enter(msg: = {}) -> void:
	animation_player.connect("animation_finished", self, "animation_player_on_animation_finished")
	animation_player.play("shoot")

func exit() -> void:
	animation_player.disconnect("animation_finished", self, "animation_player_on_animation_finished")

func physics_process(delta: float) -> void:
	_parent.physics_process(delta)

func animation_player_on_animation_finished(name: String) -> void:
	if name == 'shoot':
		_state_machine.transition_to('Move/Idle')
