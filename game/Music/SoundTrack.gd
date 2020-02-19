extends Node

var current_track : AudioStreamPlayer
var current_track_idx := -1

func _process(delta: float) -> void:
	if not current_track or not current_track.playing:
		next()
	

func next() -> void:	
	if get_child_count() == 0:
		return
	
	current_track_idx = (current_track_idx + 1) % get_child_count()
	current_track = get_child(current_track_idx) as AudioStreamPlayer
	current_track.play()
	var track : AudioStreamPlayer = get_child(current_track_idx) as AudioStreamPlayer
	if not track.playing:
		next()
