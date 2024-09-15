extends AnimatedSprite2D

@onready var timer = $Timer

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		play("walk_down")
		timer.start()
	elif Input.is_action_pressed("ui_right"):
		play("walk_down")
		timer.start()
	elif Input.is_action_pressed("ui_up"):
		play("walk_down")
		timer.start()
	elif Input.is_action_pressed("ui_down"):
		play("walk_down")
		timer.start()
	elif is_playing() and timer.is_stopped():
		stop()
