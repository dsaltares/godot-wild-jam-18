extends KinematicBody2D
class_name Player


onready var sprite := $Sprite
onready var state_machine: StateMachine = $StateMachine
onready var animation_player := $AnimationPlayer

