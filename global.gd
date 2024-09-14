extends Node

var time_left;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_left = 100
	
func change_time_left(delta) -> void:
	time_left += delta
	print(time_left)
