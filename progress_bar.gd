extends ProgressBar

var global

func _ready() -> void:
	global = get_node("/root/Global")


func _process(_delta: float) -> void:
	if not global.minotaur_time:
		value = global.time_left
	else:
		value = 0
