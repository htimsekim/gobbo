class_name Skeleman
extends enemypatrol

func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("move")
