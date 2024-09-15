extends TileMapLayer

@onready var player := $"../Player" as Node2D
@onready var floor_layer := $"../Floor" as TileMapLayer

func _ready() -> void:
	tile_set = floor_layer.tile_set
	tile_map_data = floor_layer.tile_map_data
	modulate = Color(.5,.5,.5)
	erase_cell(local_to_map(player.position))

func _process(_delta: float) -> void:
	var cell_coord = local_to_map(player.position)
	for cell_coords in get_surrounding_cells(cell_coord):
		erase_cell(cell_coords)
