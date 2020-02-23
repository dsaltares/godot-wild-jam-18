extends Node2D
class_name InfiniteLevelManager

signal done

const PlayerScene = preload("res://Player/player.tscn")

const LEVEL_WIDTH = 384

var current_level: Level
var previous_level: Level

var distance = 1

func _ready():
	# Create the first screen
	current_level = load_random_level()
	add_child(current_level)
	
	# Add the player
	spawn_player(current_level)
	
	# Add a second screen at the end
	append_new_level()

func load_random_level(height = null) -> Node2D:
	randomize()
	
	var levels = Globals.LEVELS_BY_ENTRANCE_HEIGHT[height] if height != null else Globals.LEVELS.keys()
	
	var scene = ResourceLoader.load(levels[randi() % len(levels)])
	var level = scene.instance()

	return level
	
func spawn_player(level: Level):
	var player = PlayerScene.instance()
	var player_spawn = level.find_node(("PlayerSpawn"))
	
	player.position = player_spawn.position
	player.connect("death", self, "_on_player_death")
	add_child(player)

func append_new_level():
	# Get an instance of a new random level
	var level = load_random_level(Globals.LEVELS[current_level.filename].exit_height)
	
	# Add info about how far the player has gone
	level.distance = distance
	
	# Add the level at the end of all current screens
	level.position.x = current_level.position.x + LEVEL_WIDTH
	add_child(level)
	
	# Listen to the enter event to keep spawning screens
	level.connect("player_enter", self, "_on_player_enter")

func _on_player_enter(level: Level):
	# If we are not going back to a previous screen
	if level != current_level and level != previous_level:
		# Destroy old levels
		if previous_level:
			previous_level.queue_free()
		
		# Make the new screen the current screen
		# We cannot remove current_level because it might be still in sight
		previous_level = current_level
		current_level = level
		
		# Increment the distance
		distance += 1
		
		# Append another level at the end
		call_deferred("append_new_level")

func _on_player_death() -> void:
	emit_signal("done")
