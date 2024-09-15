extends ProgressBar

var global

func _ready() -> void:
	global = get_node("/root/Global")


func _process(delta: float) -> void:
	value = global.time_left
