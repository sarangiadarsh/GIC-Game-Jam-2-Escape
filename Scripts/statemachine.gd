class_name StateMachine
extends Node

@export 
var CURRENT_STATE: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible child node(s)")
	CURRENT_STATE.Enter()
	
func _process(delta: float) -> void:
	CURRENT_STATE._update(delta)
	
func _physics_process(delta: float) -> void:
	CURRENT_STATE._physics_update(delta)
	GLOBAL.debug.add_property("Current State",str(CURRENT_STATE.name),1)
	
func on_child_transition(new_state_name:StringName) ->void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != CURRENT_STATE:
			CURRENT_STATE.Exit()
			new_state.Enter()
			CURRENT_STATE  = new_state
	else:
		push_warning("State does not exist")
