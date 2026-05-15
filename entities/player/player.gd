class_name Player extends CharacterBody2D


@export_group("Stats")
@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 60.0
@export var damage: float = 5.0
@export var critical_chance: float = 0.0
@export var critical_damage: float = 0.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm: FSM = $FSM
@onready var health: Health = $Components/Health
@onready var mana: Mana = $Components/Mana

var last_direction: String = "down"	
var current_mana: float = 0.0

func _ready() -> void:
	pass


# process logic every frame
func _process(delta: float) -> void:
	
	if fsm.current_state:
		fsm.current_state.process_state(delta)
	
	pass

func set_up() -> void:
	reset_health()
	reset_mana()
	pass	

func reset_health() -> void:
	health.setup(max_health)
	EventBus.on_player_health_updated.emit(max_health, max_health)
	pass
	
func reset_mana() -> void:
	mana.setup(max_mana)
	EventBus.on_player_mana_updated.emit(max_mana, max_mana)
	pass	
	
func use_mana(value: float) -> void:
	mana.use_mana(value)
	EventBus.on_player_mana_updated.emit(mana.current_mana, max_mana)
	pass		
			
#----------------------------
############# MOVEMENT	
#----------------------------

	
func is_moving() -> bool:
	var 	move_input = ["move_down", "move_up", "move_left", "move_right"]
	
	for input in move_input:
		if Input.is_action_pressed(input):
			return true
			
	return false
	pass		
	
func update_direction(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return
	
	if abs(input_vector.x) > abs(input_vector.y):
		last_direction = "right" if input_vector.x > 0 else "left"	
	else:
		last_direction = "down" if input_vector.y > 0 else "up"		
	pass
	
func play_direction_animation(animation_name: String) -> void:
	animated_sprite_2d.play("%s_%s" % [animation_name, last_direction])
	pass	
	
	
	
	
		
