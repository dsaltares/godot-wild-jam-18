extends Node

enum DIFFICULTY { EASY, MEDIUM, HARD }
enum LEVEL_HEIGHT { LOW, HIGH }

var LEVELS = {
	"res://Levels/level1.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.LOW
	},
	"res://Levels/level2.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.LOW
	},
	"res://Levels/level3.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.HIGH
	},
	"res://Levels/level4.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.HIGH
	}
}

var LEVELS_BY_ENTRANCE_HEIGHT = {
	LEVEL_HEIGHT.LOW: [
		"res://Levels/level1.tscn",
		"res://Levels/level3.tscn"
	],
	LEVEL_HEIGHT.HIGH: [
		"res://Levels/level2.tscn",
		"res://Levels/level4.tscn"
	]
}
