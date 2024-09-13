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
	var collision_data = KinematicCollision2D.new()
	var collision = test_move(transform, motion, collision_data)
	if MOVEMENT_COST <= 0:
		if not collision:
			position += motion
		else:
			var collider = collision_data.get_collider()
			if collider.has_method("collide"):
				var coordinates = (position/MOVE_DISTANCE)+direction
				collider.call("collide", coordinates)
				
		MOVEMENT_COST = 1
