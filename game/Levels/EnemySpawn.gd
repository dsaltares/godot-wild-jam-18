extends Node2D

class_name EnemySpawn

export(float, 0, 1) var enemy_probability = 1

export(Globals.DIFFICULTY) var enemy_max_level = Globals.DIFFICULTY.EASY

const ENEMIES = [
	"res://Enemies/Brain/Brain.tscn",
	"res://Enemies/Alien/Alien.tscn",
	"res://Enemies/Darklord/Darklord.tscn" 
]

func _ready():
	# Calculate a coefficient that increases with distance
	var distance = get_parent().distance
	var coef = 1 + (distance / 50.0)
	
	# Roll a number to spawn an enemy
	randomize()
	var roll = randf()
	
	if roll < coef * enemy_probability:
		var enemy_difficulty = randi() % (enemy_max_level + 1)
		var enemy_scene = ResourceLoader.load(ENEMIES[enemy_difficulty])
		var enemy = enemy_scene.instance()
		
		add_child(enemy)
