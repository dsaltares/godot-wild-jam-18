extends Node2D

class_name ItemDrop

export(float, 0,1) var item_probability = 0.1

const ITEM = "res://Items/Ammo/Ammo.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Roll a number to spawn an enemy
	randomize()
	var roll = randf()
	
	if roll < item_probability:
		var item_scene = ResourceLoader.load(ITEM)
		var item = item_scene.instance()
		
		add_child(item)
