extends BrainState
class_name BrainMove

const MAX_SPEED = 100
const TIME_TO_MAX_SPEED = 0.5


func _ready() -> void:
	yield(owner, "ready")
	detection_area.connect("body_entered", self, "on_DetectionArea_body_entered")

func _exit_tree() -> void:
	detection_area.disconnect("body_entered", self, "on_DetectionArea_body_entered")

func on_DetectionArea_body_entered(body: Node) -> void:
	if not body is Player:
		return
	
	var player := body as Player
	print('player entered')
