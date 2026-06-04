class_name Npc extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer

enum NpcType {
	IDLE,
	SHOP,
	QUEST,
	CRAFTING
}

@export var type: NpcType
@export var movement: NpcMovementResource
@export var dialogue: DialogueResource

var last_direction: String = "down"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not movement.can_move: return
	
	await get_tree().process_frame
	
	_set_new_target()
		
	
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not movement.can_move: return
	
	
	if _is_waiting_for_next_move():
		_play_animation("idle")
		return
		
	if _has_reached_target():
		if timer.is_stopped():
			timer.start()
		return
	
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	var direction = self.global_position.direction_to(next_path_position)			
	global_position += direction * movement.move_speed * delta
	
	_update_direction(direction)
	
	_play_animation("move")
	pass



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
	#if event.is_action_pressed("interact") && not DialogueGlobal.is_active: # TODO: I want to interact using keyboard
		if dialogue:
			DialogueGlobal.on_dialogue_started.emit(dialogue)
			DialogueGlobal.is_active = true
	pass # Replace with function body.

func _set_new_target() -> void:
	
	if not NpcGlobal.navigation: return
	
	var used_cells: Array[Vector2i] = NpcGlobal.navigation.get_used_cells()
	
	if used_cells.is_empty(): return
	
	var random_cell: Vector2i = used_cells.pick_random()
	var world_position : Vector2 = NpcGlobal.navigation.to_global(NpcGlobal.navigation.map_to_local(random_cell))
	
	navigation_agent_2d.target_position = world_position
	
	pass
	
func _is_waiting_for_next_move() -> bool:
	return not timer.is_stopped()
	pass	

func _has_reached_target() -> bool:
	return navigation_agent_2d.is_navigation_finished()
	pass

func _play_animation(animation_name: String) -> void:
	animated_sprite_2d.play("%s_%s" % [animation_name, last_direction])
	pass
	
func _update_direction(direction: Vector2) -> void:
	if abs(direction.x) > abs(direction.y):
		last_direction = "right" if direction.x > 0 else "left"
	else:
		last_direction = "down" if direction.y > 0 else "up"	
	pass	

func _on_timer_timeout() -> void:
	_set_new_target()
	pass 
