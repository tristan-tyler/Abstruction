extends CharacterBody2D

const MOVE_DISTANCE = Vector2(16,16)

var MOVEMENT_COST = 0

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		move(Vector2.LEFT, delta)
	if Input.is_action_pressed("ui_right"):
		move(Vector2.RIGHT, delta)
	if Input.is_action_pressed("ui_up"):
		move(Vector2.UP, delta)
	if Input.is_action_pressed("ui_down"):
		move(Vector2.DOWN, delta)
	
func move(direction: Vector2, delta: float):
	if MOVEMENT_COST > 0:
		MOVEMENT_COST -= delta
	var motion = direction*MOVE_DISTANCE
	var collision = test_move(transform, motion)
	if MOVEMENT_COST <= 0 and not collision:
		MOVEMENT_COST = 1
		position += motion
	
