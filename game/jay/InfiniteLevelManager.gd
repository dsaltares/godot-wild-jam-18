extends Node2D

const player_scene = preload("res://Player/player.tscn")

const LEVEL_WIDTH = 384
const LEVELS = [
	"res://Levels/level1.tscn",
	"res://Levels/level2.tscn",
	"res://Levels/level3.tscn"
]

var current_level: Level
var previous_level: Level

func _ready():
	# Create the first screen
	current_level = load_random_level()
	add_child(current_level)
	
	# Add the player
	spawn_player(current_level)
	
	# Add a second screen at the end
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
	add_child(player)

func append_new_level():
	# Get an instance of a new random level
	var level = load_random_level()
	
	# Add the level at the end of all current screens
	level.position.x = current_level.position.x + LEVEL_WIDTH
	add_child(level)
	
	# Listen to the enter event to keep spawning screens
	level.connect("player_enter", self, "_on_player_enter")

func _on_player_enter(level: Level):
	# If we are not going back to a previous screen
	if level != current_level:
		# Destroy old levels
		if previous_level:
			previous_level.queue_free()
		
		# Make the new screen the current screen
		# We cannot remove current_level because it might be still in sight
		previous_level = current_level
		current_level = level
		
		# Append another level at the end
		append_new_level()
	
