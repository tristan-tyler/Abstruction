extends Node2D

@onready var tiles := $"../Floor" as TileMapLayer
@onready var astar_grid = AStarGrid2D.new()
var tile_rect: Rect2i
var tilemap_size: Vector2i

func _ready():
	if !tiles: return
	tile_rect = Rect2i(tiles.get_used_rect())
	init_astar()

func init_astar():
	var tile_size = tiles.tile_set.get_tile_size()
	astar_grid.region = tile_rect
	astar_grid.cell_size = tile_size
	astar_grid.set_default_compute_heuristic(AStarGrid2D.HEURISTIC_MANHATTAN)
	astar_grid.set_default_estimate_heuristic(AStarGrid2D.HEURISTIC_MANHATTAN)
	astar_grid.set_diagonal_mode(AStarGrid2D.DIAGONAL_MODE_NEVER)
	astar_grid.set_offset(Vector2i.ONE*tile_size/2)
	astar_grid.update()
	read_tiles()

func read_tiles():
	tilemap_size = tiles.get_used_rect().end - tiles.get_used_rect().position
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var cell = Vector2i(i, j)
			var tile_data = tiles.get_cell_tile_data(cell)
			if not tile_data or not walkable(tiles.map_to_local(cell)):
				astar_grid.set_point_solid(cell)
				continue

func set_cell_solid(target_position: Vector2):
	var cell = tiles.local_to_map(target_position)
	astar_grid.set_point_solid(cell)

func walkable(target_position: Vector2):
	var map_position = tiles.local_to_map(target_position)
	return tile_rect and tile_rect.has_point(map_position) and not astar_grid.is_point_solid(map_position)

func get_navigation_path(start_position: Vector2, end_position: Vector2):
	var grid_start_cell = tiles.local_to_map(start_position)
	var grid_end_cell = tiles.local_to_map(end_position)
	return astar_grid.get_point_path(grid_start_cell, grid_end_cell)
