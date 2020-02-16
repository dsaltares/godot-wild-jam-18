extends BrainState
class_name BrainIdle


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)

func enter(msg: = {}) -> void:
	animation_player.play("idle")
