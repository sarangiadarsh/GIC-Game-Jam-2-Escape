extends Node3D

@export var sensitivity:float = .002
@onready var springarm: SpringArm3D = $springarm

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x *  sensitivity
		rotation.y = wrapf(rotation.y,0.0, TAU)
		
		rotation.x -= event.relative.y *  sensitivity
		rotation.x = clamp(rotation.x, -PI/2, PI/4)
	
		
	if event.is_action_pressed("wheel_up") and springarm.spring_length >1:
		springarm.spring_length -= 1
	if event.is_action_pressed("wheel_down") and springarm.spring_length <9:
		springarm.spring_length += 1
	
	if event.is_action_pressed("toggle_mouse_capture"):
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	if event.is_action_released("toggle_mouse_capture"):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
