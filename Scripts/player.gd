extends CharacterBody3D


const WALK_SPEED = 2.0
const JUMP_VELOCITY = 9
const SPRINT_SPEED = 9

var speed = WALK_SPEED
var frames_per_second
var current_velocity
@onready var visuals: Node3D = $visuals
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var springarmpivot: Node3D = $springarmpivot
@onready var camera: Camera3D = $springarmpivot/Camera3D

@export  var rotation_lerp_power:float  = 5.0

func _ready() -> void:
	GLOBAL.player = self
	
func _process(delta: float) -> void:
	frames_per_second = "%.2f" %(1.0/delta)
	GLOBAL.debug.add_property("FPS",frames_per_second,0)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity+= get_gravity() * delta
		if velocity.y <  0:
			velocity += get_gravity() * delta * 2
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	elif !is_on_floor():
		pass
	else:
		speed = WALK_SPEED
		
	if direction:
		visuals.look_at(position + direction)
		rotation.y = wrapf(rotation.y,0.0, TAU)	
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	
	move_and_slide()
