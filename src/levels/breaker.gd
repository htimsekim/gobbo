extends TileMap

export var environment = ""

func _ready():
	if environment != "":
		#Gets coordinates (x, y) of all used cells 
		var cells = get_used_cells()
		var breakableTile = load("res://src/Objects/breaker_" + environment + ".tscn")
	
		#Clear all the existing tiles
		clear()
	
		#Loop through all the cells, spawn the preloaded object, make it tilemap's child
		#and reposition it to wherever the cell was before.
		for cell in cells:
			var new_tile = breakableTile.instance()
			add_child(new_tile)
			new_tile.global_position = Vector2(cell.x * cell_size.x, cell.y * cell_size.y)
