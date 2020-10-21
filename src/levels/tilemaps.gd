extends Node2D

func _ready():
	connect("collided", self, "_on_Character_collided")
	
func _on_Character_collided(collision):
	print("t")
	# KinematicCollision2D object emitted by character
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map($Character.position)
		tile_pos -= collision.normal  # Colliding tile
		var tile = collision.collider.get_cellv(tile_pos)
		if tile > 0:
			$TileMap.set_cellv(tile_pos, tile-1)
