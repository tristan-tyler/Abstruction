extends TileMapLayer


func collide(actor_position: Vector2, direction: Vector2) -> Vector2:
	$AudioStreamPlayer.play()
	return Vector2(1,0)
