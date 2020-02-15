extends State
class_name PlayerState

var player: Node
var sprite: Sprite
var playback: AnimationNodeStateMachinePlayback

func _ready() -> void:
	yield(owner, 'ready')
	player = owner
	sprite = owner.sprite
	playback = owner.playback
