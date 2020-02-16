extends Node2D

const player_node = preload("res://Player/player.tscn")

const LEVELS = [
	"res://Levels/level1.tscn",
	"res://Levels/level2.tscn",
	"res://Levels/level3.tscn"
]

func _ready():
	randomize()
	var scene = ResourceLoader.load(LEVELS[randi() % 3])
	var level = scene.instance()
	
	var player = player_node.instance()
	
	add_child(level)
	
	var player_spawn = level.find_node('PlayerSpawn')
	player.position = player_spawn.position
	
	level.add_child(player)
