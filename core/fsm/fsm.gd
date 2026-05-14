class_name FSM extends Node

signal on_state_transitioned(state_name: String)

@export var initial_state: NodePath

var current_state: State


func _ready() -> void:
	
	await owner.ready #to avoid errors if a scene or a node is not loaded
	
	for state: State in get_children():
		state.fsm = self
	
	
	current_state = get_node(initial_state)
	current_state.enter_state()
	pass
	
func transition_to(state_name: String) -> void:
	
	if not has_node(state_name):
		return
	
	current_state.exit_state()
	current_state = get_node(state_name)
	current_state.enter_state()
	
	on_state_transitioned.emit(state_name)
	pass
