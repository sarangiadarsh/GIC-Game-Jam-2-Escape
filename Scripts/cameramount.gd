extends Node3D


@onready var springarm: SpringArm3D = $springarm

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		GLOBAL.player.rotation.y -= event.relative.x * GLOBAL.sensitivity
		GLOBAL.player.rotation.y =  wrapf(GLOBAL.player.rotation.y,0,2*PI)
		rotation.x -= event.relative.y *  GLOBAL.sensitivity
		rotation.x = clamp(rotation.x, -PI/2, PI/4)
	
		
	if event.is_action_pressed("wheel_up") and springarm.spring_length >1:
		springarm.spring_length -= 1
	if event.is_action_pressed("wheel_down") and springarm.spring_length <9:
		springarm.spring_length += 1
	
	if event.is_action_pressed("toggle_mouse_capture"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_released("toggle_mouse_capture"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
