extends TileMapLayer

func collide(_actor_position: Vector2, _direction: Vector2) -> Vector2:
	$Bump.play()
	return Vector2(1,0)

func destroy(_target_position: Vector2):
	return -1
