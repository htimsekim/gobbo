extends Node2D

export(String) var npc_animation
var rng = RandomNumberGenerator.new()

func _ready():
	var goblins = $AnimationPlayer.get_animation_list()
	
	rng.randomize()
	$AnimationPlayer.set_speed_scale(rng.randf_range(0.1, 0.2))
	$AnimationPlayer.play(goblins[randi() % goblins.size()])
	
	print(goblins[randi() % goblins.size()])
