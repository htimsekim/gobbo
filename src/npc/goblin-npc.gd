extends Node2D

export(String) var npc_animation
var rng = RandomNumberGenerator.new()

func _ready():
	var goblins = $AnimationPlayer.get_animation_list()
	var anim = $AnimationPlayer.get_animation(goblins[int(self.get_name().trim_prefix("goblin-npc"))-1])
	anim.set_loop(true)
	rng.randomize()
	
	
	$AnimationPlayer.set_speed_scale(rng.randf_range(0.1, 0.2))
	$AnimationPlayer.play(goblins[int(self.get_name().trim_prefix("goblin-npc"))-1])
	

