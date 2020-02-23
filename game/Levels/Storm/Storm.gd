extends Node2D

const MIN_CLEAR_DURATION = 15
const MAX_CLEAR_DURATION = 30

const MIN_STORM_DURATION = 10
const MAX_STORM_DURATION = 25

const MIN_LIGHTNING_INTERVAL = 2
const MAX_LIGHTNING_INTERVAL = 6

onready var rain := $Rain
onready var lightning := $Lightning
onready var storm_timer := $StormDuration
onready var clear_timer := $ClearDuration
onready var lightning_timer := $LightningInterval

var in_storm = false

func _ready() -> void:
	storm_timer.connect("timeout", self, "_on_StormDuration_timeout")
	clear_timer.connect("timeout", self, "_on_ClearDuration_timeout")
	lightning_timer.connect("timeout", self, "_on_LightningInterval_timeout")
	start_storm()
	
func stop_storm() -> void:
	in_storm = false
	storm_timer.stop()
	lightning_timer.stop()
	rain.disable()
	clear_timer.wait_time = rand_range(MIN_CLEAR_DURATION, MAX_CLEAR_DURATION)
	clear_timer.start()
	
func start_storm() -> void:
	in_storm = true
	rain.enable()
	clear_timer.stop()
	storm_timer.wait_time = rand_range(MIN_STORM_DURATION, MAX_STORM_DURATION)
	storm_timer.start()
	_ready_lightning()


func _ready_lightning() -> void:
	lightning_timer.wait_time = rand_range(MIN_LIGHTNING_INTERVAL, MAX_LIGHTNING_INTERVAL)
	lightning_timer.start()

func _on_StormDuration_timeout() -> void:
	stop_storm()
	
func _on_ClearDuration_timeout() -> void:
	start_storm()
	
func _on_LightningInterval_timeout() -> void:
	lightning.strike()
	_ready_lightning()
