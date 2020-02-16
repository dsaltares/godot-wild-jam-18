extends Camera2D

var player
var camera_dimensions

func _ready():
	player = get_parent().find_node("Player", true, false)
	camera_dimensions = get_viewport().size * zoom

func _process(delta):
	if !player:
		player = get_parent().find_node("Player", true, false)
		return
	
	if player.position.x > position.x:
		position.x = player.position.x
