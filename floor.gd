extends TileMapLayer


func collide(actor_position: Vector2, direction: Vector2) -> int:
	$AudioStreamPlayer.play()
	return 1
