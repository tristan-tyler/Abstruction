extends Node2D

var global
var music_change_flag: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global = get_node("/root/Global")
	$BrackeysSong1.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not music_change_flag and global.time_left < 0:
		music_change_flag =  true
		$BrackeysSong1.stop()
		$BrackeysSong2.play()
