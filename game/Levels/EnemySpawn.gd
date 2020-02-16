extends Node2D

class_name EnemySpawn

export(float, 0, 1) var enemy_probability = 1
export(int, "Easy", "Medium", "Hard") var enemy_max_level

const ENEMIES = [
	"res://Enemies/Alien/Alien.tscn",
	"res://Enemies/Brain/Brain.tscn",
	"res://Enemies/Darklord/Darklord.tscn" 
]

func _ready():
	randomize()
	var roll = randf()
	
	if roll < enemy_probability:
		var enemy_scene = ResourceLoader.load(ENEMIES[randi() % 3])
		var enemy = enemy_scene.instance()
		
		add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
