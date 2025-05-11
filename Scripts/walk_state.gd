class_name WalkState

extends State



func _update(delta: float) -> void:
	GLOBAL.player.animation_player.play("Walk/Walk")
	
	if Input.is_action_pressed("sprint"):
		transition.emit("SprintState")
		print("Sprinting")
	
	if GLOBAL.player.velocity.x == 0 and GLOBAL.player.velocity.z == 0:
		transition.emit("IdleState")
		print("Idling")
		
	if GLOBAL.player.velocity.y > 0:
		transition.emit("JumpState")
		print("Jumping")
