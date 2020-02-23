extends Node

enum DIFFICULTY { EASY, MEDIUM, HARD }
enum LEVEL_HEIGHT { LOW, HIGH }

var LEVELS = {
	"res://Levels/level1.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.HIGH
	},
	"res://Levels/level2.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.HIGH
	},
	"res://Levels/level3.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.LOW
	},
	"res://Levels/level4.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.LOW
	},
	"res://Levels/level5.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.HIGH
	},
	"res://Levels/level6.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.HIGH
	},
	"res://Levels/level7.tscn": {
		"entrance_height": LEVEL_HEIGHT.LOW,
		"exit_height": LEVEL_HEIGHT.LOW
	},
	"res://Levels/level8.tscn": {
		"entrance_height": LEVEL_HEIGHT.HIGH,
		"exit_height": LEVEL_HEIGHT.LOW
	}
}

var LEVELS_BY_ENTRANCE_HEIGHT = {
	LEVEL_HEIGHT.LOW: [
		"res://Levels/level2.tscn",
		"res://Levels/level4.tscn",
		"res://Levels/level5.tscn",
		"res://Levels/level7.tscn"
	],
	LEVEL_HEIGHT.HIGH: [
		"res://Levels/level1.tscn",
		"res://Levels/level3.tscn",
		"res://Levels/level6.tscn",
		"res://Levels/level8.tscn"
	]
}
