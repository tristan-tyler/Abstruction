extends AnimatedSprite2D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		play("walk_left")
	if Input.is_action_pressed("ui_right"):
		play("walk_right")
	if Input.is_action_pressed("ui_up"):
		play("walk_up")
	if Input.is_action_pressed("ui_down"):
		play("walk_down")
