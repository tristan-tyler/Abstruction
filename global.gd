extends Node2D

var time_left
var minotaur_time: bool

func change_time_left(delta) -> void:
	time_left += delta
	if time_left == 0:
		minotaur_time = true

func restart() -> void:
	get_tree().reload_current_scene()
