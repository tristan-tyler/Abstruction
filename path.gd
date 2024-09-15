extends Node2D


@onready var minotaur := $"../Minotaur"

func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if minotaur and minotaur.current_point_path:
		draw_polyline(minotaur.current_point_path, Color.DEEP_PINK)
