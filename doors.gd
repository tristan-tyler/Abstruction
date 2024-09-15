extends TileMapLayer

var TILE_RUNTIME_UPDATE = {}

func _add_tile_update(coords: Vector2i):
	TILE_RUNTIME_UPDATE[coords] = true
	
func _remove_tile_update(coords: Vector2i):
	TILE_RUNTIME_UPDATE.erase(coords)

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return TILE_RUNTIME_UPDATE.get(coords)		

func collide(actor_position: Vector2, direction: Vector2) -> Vector2:
	var effort = 0
	var cell_coords = Vector2i.ONE*local_to_map(actor_position)+Vector2i(direction)
	var cell_data = get_cell_tile_data(cell_coords)
	var cell_source_id = get_cell_source_id(cell_coords)	
	var cell_atlas_coords = get_cell_atlas_coords(cell_coords)
	var cell_alternative_tile = get_cell_alternative_tile(cell_coords)
	
	if not cell_data: return Vector2(effort, 1)
	
	if cell_data.get_custom_data("can_open"):
		$DoorOpen.play()
		if cell_data.get_custom_data("is_open"):
			cell_alternative_tile = 0
		else:
			cell_alternative_tile = 2 + direction.x

	if cell_data.get_custom_data("movable"):
		var push_distance = cell_data.get_custom_data("push_distance") + direction
		effort += 1
		var old_cell_coords = cell_coords
		cell_coords = cell_coords+Vector2i(push_distance)
		cell_data = get_cell_tile_data(cell_coords)
		if cell_data:
			if not cell_data.get_custom_data("kinetic") or not cell_data.get_custom_data("movable"):
				return Vector2(effort, 1)
			var carry = collide(map_to_local(old_cell_coords), direction)
			if carry.y == 1: return carry 
			effort += carry.x
		erase_cell(old_cell_coords)

	set_cell(cell_coords, cell_source_id, cell_atlas_coords, cell_alternative_tile)
	
	return Vector2(effort, 0)

func destroy(target_position: Vector2):
	var cell_coords = Vector2i.ONE*local_to_map(target_position)
	var cell_data = get_cell_tile_data(cell_coords)
	var cell_source_id = get_cell_source_id(cell_coords)	
	var cell_atlas_coords = get_cell_atlas_coords(cell_coords)
	if not cell_data: return 0
	var difficulty = cell_data.get_custom_data("destroy_difficulty")
	if difficulty > 0 or cell_data.get_custom_data("brittle"):
		set_cell(cell_coords, cell_source_id, cell_atlas_coords*Vector2i.DOWN)
		$WallBreak.play()
	return difficulty
