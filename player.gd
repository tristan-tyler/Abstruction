extends CharacterBody2D

const MOVE_DISTANCE = Vector2(16,16)
var global

func _ready() -> void:
	global = get_node("/root/Global")

func _input(event) -> void:
	if event.is_action_pressed("ui_left"):
		move(Vector2.LEFT)
	if event.is_action_pressed("ui_right"):
		move(Vector2.RIGHT)
	if event.is_action_pressed("ui_up"):
		move(Vector2.UP)
	if event.is_action_pressed("ui_down"):
		move(Vector2.DOWN)
	
func move(direction: Vector2):
	var motion = direction*MOVE_DISTANCE
	var collision_data = KinematicCollision2D.new()
	var collision = test_move(transform, motion, collision_data)

	if not collision:
		position += motion
		$Footstep.pitch_scale = randf_range(2,2.4)
		$Footstep.play()
	else:
		var collider = collision_data.get_collider()
		if collider.has_method("collide"):
			var move_cost = collider.call("collide", position, direction).x
			global.change_time_left(-move_cost)
			
	global.change_time_left(-1)

func destroy(_target_position: Vector2):
	global.restart()
	return 0
