extends Node2D

const player_scene = preload("res://Player/player.tscn")

const LEVEL_WIDTH = 384
const LEVELS = [
	"res://Levels/level1.tscn",
	"res://Levels/level2.tscn",
	"res://Levels/level3.tscn"
]

var current_level

func _ready():
	current_level = load_random_level()
	add_child(current_level)
	spawn_player(current_level)
	
	append_new_level()

func load_random_level() -> Node2D:
	randomize()
	var scene = ResourceLoader.load(LEVELS[randi() % 3])
	var level = scene.instance()
	
	return level
	
func spawn_player(level: Node):
	var player = player_scene.instance()
	var player_spawn = level.find_node(("PlayerSpawn"))
	
	player.position = player_spawn.position
	level.add_child(player)

func append_new_level():
	var level = load_random_level()
	level.position.x = current_level.position.x + LEVEL_WIDTH
	
	add_child(level)
