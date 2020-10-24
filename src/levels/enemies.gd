extends TileMap

#enemy references based on "enemies" tileset and offset for each enemy because idk how else to do it tbh
const enemies = {
	"0": ["res://src/characters/enemybat.tscn", Vector2(0,6)],
	"1": ["res://src/characters/enemycrawler.tscn", Vector2(0,8)],
	"2": ["res://src/characters/enemyoculon.tscn", Vector2(0,0)]
}

func _ready():
	#Gets coordinates (x, y) of all used cells 
	var cells = get_used_cells()
	
	#loop thru cells containing enemies
	for cell in cells:
		#godot wont let me use integer as dictionary key so i have to cast to str
		var enemy_type = load(enemies[str(get_cellv(cell))][0])
		var new_enemy = enemy_type.instance()
		add_child(new_enemy)
		#set position to cell position + offset from dict
		new_enemy.global_position = Vector2(cell.x * cell_size.x, cell.y * cell_size.y) + enemies[str(get_cellv(cell))][1]
	
	#have to clear at the end or else all cellv's end up being -1
	clear()
