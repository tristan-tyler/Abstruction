extends TileMapLayer


func move(tile_coords: Vector2) -> void:
	var translation_map = {
		Vector3(1,2,1):Vector3(1,1,1),
		Vector3(1,1,1):Vector3(1,2,1),
		Vector3(1,2,0):Vector3(0,1,1),
		Vector3(0,1,1):Vector3(1,2,0)
		}
	var tile_alt = get_cell_alternative_tile(tile_coords)
	var tile_atlas_coords = get_cell_atlas_coords(tile_coords)
	var tile_source_id = get_cell_source_id(tile_coords)
	
	var variant = translation_map.get(Vector3(tile_atlas_coords.x, tile_atlas_coords.y, tile_alt))
	
	if variant:
		set_cell(tile_coords, tile_source_id, Vector2(variant.x, variant.y), variant.z)
