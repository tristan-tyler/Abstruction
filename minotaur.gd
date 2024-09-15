extends CharacterBody2D

const MOVE_DISTANCE = Vector2.ONE*16

@onready var navigation := $"../NavigationManager"
@onready var player := $"../Player"
var current_point_path: PackedVector2Array
var move_cost: int
var global

func _ready() -> void:
	global = get_node("/root/Global")
	$AnimationSprites.visible = false
	$CollisionShape2D.one_way_collision = true

func _on_timer_timout() -> void:
	current_point_path = navigation.get_navigation_path(global_position, player.global_position).slice(1)
	print(current_point_path)
	if move_cost > 0: move_cost -= 1

func _process(_delta: float) -> void:
	if global.time_left > 0:
		return
	elif global.time_left < 0:
		move_cost -= 1
		global.change_time_left(1)
		$AnimationSprites.visible = true

	if move_cost > 0: return
	if not current_point_path: return
	var base_position = current_point_path[0]
	
	var two_by_two = [
		base_position,
		base_position+Vector2.RIGHT*8,
		base_position+Vector2.DOWN*8+Vector2.RIGHT*8,
		base_position+Vector2.DOWN*8
	]
	
	for target_position in two_by_two:
		if not navigation.walkable(target_position): return

		var motion = (-(position-base_position)/16)*MOVE_DISTANCE
		var collision_data = KinematicCollision2D.new()
		var collision = test_move(transform, motion, collision_data)
		
		if not collision:
			position = base_position
			move_cost += 1
			break
		else:
			var collider = collision_data.get_collider()
			if collider.has_method("destroy"):
				var destory_cost = collider.call("destroy", target_position)
				if destory_cost == -1:
					navigation.set_cell_solid(target_position)
				else:
					move_cost += destory_cost
