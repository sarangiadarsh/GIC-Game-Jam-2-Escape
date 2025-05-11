class_name SprintState

extends State



func _update(delta: float) -> void:
	GLOBAL.player.animation_player.play("Sprint/Sprint")
	
	if Input.is_action_just_released("sprint"):
		transition.emit("SprintState")
		print("Walking")
	
	if GLOBAL.player.velocity.x == 0 and GLOBAL.player.velocity.z == 0:
		transition.emit("IdleState")
		print("Idling")
	
	if GLOBAL.player.velocity.y > 0:
		transition.emit("JumpState")
		print("JumpState")
