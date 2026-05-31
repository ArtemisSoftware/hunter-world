class_name Npc extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

enum NpcType {
	IDLE,
	SHOP,
	QUEST,
	CRAFTING
}

@export var type: NpcType
@export var movement: NpcMovementResource
@export var dialogue: DialogueResource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
	#if event.is_action_pressed("interact") && not DialogueGlobal.is_active: # TODO: I want to interact using keyboard
		if dialogue:
			DialogueGlobal.on_dialogue_started.emit(dialogue)
			DialogueGlobal.is_active = true
	pass # Replace with function body.
