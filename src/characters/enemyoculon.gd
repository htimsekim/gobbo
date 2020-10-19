class_name Oculon
extends enemypatrolFLY

func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("hover")
