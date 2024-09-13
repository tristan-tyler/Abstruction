extends TileMapLayer


func collide(__) -> void:
	$AudioStreamPlayer.play()
