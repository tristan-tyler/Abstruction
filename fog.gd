extends TileMapLayer


func _ready() -> void:
	tile_set = $"../Floor".tile_set
	tile_map_data = $"../Floor".tile_map_data
	modulate = Color(.5,.5,.5)
	erase_cell(local_to_map($"../Player".position))

func _process(delta: float) -> void:
	var cell_coord = local_to_map($"../Player".position)
	for cell_coords in get_surrounding_cells(cell_coord):
		erase_cell(cell_coords)
