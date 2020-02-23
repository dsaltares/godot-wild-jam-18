extends Node

enum State {
	Intro,
	Game,
	Death
}

onready var IntroScreen = preload("res://Menus/Intro.tscn")
onready var GameScreen = preload("res://Levels/InfiteLevelManager.tscn")
onready var DeathScreen = preload("res://Menus/Death.tscn")

onready var current_root = $CurrentSceneRoot

var state = State.Intro
var intro : IntroScreen
var death : DeathScreen
var game : InfiniteLevelManager

func _ready() -> void:
	load_intro()

func _on_IntroScreen_done() -> void:
	print("on_IntroScreen_done")
	clear_intro()
	call_deferred("load_game")
	
func _on_DeathScreen_done() -> void:
	clear_death()
	load_game()
	
func _on_GameScreen_done(final_score: int) -> void:
	clear_game()
	load_death(final_score)
	
func load_intro() -> void:
	print("load_intro")
	intro = IntroScreen.instance()
	current_root.add_child(intro)
	get_tree().set_current_scene(intro)
	intro.connect("done", self, "_on_IntroScreen_done")
	
func clear_intro() -> void:
	if intro:
		intro.queue_free()
		intro = null
	
func load_game() -> void:
	game = GameScreen.instance()
	current_root.add_child(game)
	get_tree().set_current_scene(game)
	game.connect("done", self, "_on_GameScreen_done")
	
func clear_game() -> void:
	if game:
		game.queue_free()
		game = null
	
func load_death(final_score: int) -> void:
	death = DeathScreen.instance()
	death.final_score = final_score
	current_root.add_child(death)
	get_tree().set_current_scene(death)
	death.connect("done", self, "_on_DeathScreen_done")

func clear_death() -> void:
	if death:
		death.queue_free()
		death = null
