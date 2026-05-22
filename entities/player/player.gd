class_name Player extends CharacterBody2D


@export_group("Stats")
@export var stats: Stats

@export_group("Experience")
@export var base_exp: float = 100.0
@export var exp_multiplier: float = 2.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm: FSM = $FSM
@onready var health: Health = $Components/Health
@onready var mana: Mana = $Components/Mana
@onready var exp: Experience = $Components/Exp
@onready var enemy_attack_area: Area2D = $Weapon/EnemyAttackArea
@onready var weapon: Node2D = $Weapon


@onready var attack_positions: Dictionary = {
	"down": %"Down Marker2D",
	"up": %"Up Marker2D4",
	"left": %"Left Marker2D",
	"right": %"Right Marker2D"
}


var last_direction: String = "down"	



func _ready() -> void:
	
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		exp.add_exp(10)
		#health.take_damage(1.0)
		#mana.use_mana(1.0)
	pass	


# process logic every frame
func _process(delta: float) -> void:
	
	if fsm.current_state:
		fsm.current_state.process_state(delta)
	
	pass

func set_up() -> void:
	
	reset_health()
	reset_mana()
	exp.setup(base_exp, exp_multiplier)
	exp.on_next_level.connect(EventBus.on_player_new_level.emit)
	exp.on_experience_updated.connect(EventBus.on_player_stats_updated.emit)

	stats.on_stat_upgrade.connect(_on_stat_upgrade)
	pass	

func reset_health() -> void:
	health.setup(stats.max_health)
	EventBus.on_player_health_updated.emit(stats.max_health, stats.max_health) #TODO: dont understand the use of this
	pass
	
func reset_mana() -> void:
	mana.setup(stats.max_mana)
	EventBus.on_player_mana_updated.emit(stats.max_mana, stats.max_mana) #TODO: dont understand the use of this
	pass	
	
func use_mana(value: float) -> void:
	mana.use_mana(value)
	EventBus.on_player_mana_updated.emit(stats.mana.current_mana, stats.max_mana) #TODO: dont understand the use of this
	pass		
	
func add_mana(value: float) -> void:
	mana.add_mana(value)
	EventBus.on_player_mana_updated.emit(stats.mana.current_mana, stats.max_mana) #TODO: dont understand the use of this
	pass			

func _on_stat_upgrade(type: Stats.Type) -> void:
	
	match type:
		Stats.Type.STRENGHT: reset_health()
		Stats.Type.INTELLINGENCE: reset_mana()
	
	exp.consume_points()
	EventBus.on_player_stats_updated.emit()
	pass
	
	
func get_damage(skill_dmg: float = 0.0) -> float:
	
	var total_dmg = stats.damage + skill_dmg
	
	for equipment: EquipmentItem in EquipmentGlobal.equipment.values():
		
		if equipment:
			total_dmg += equipment.bonus_damage
	
	if randf() * 100 <= stats.critical_chance:
		total_dmg *= (1.0 + (stats.critical_damage / 100.0))
		
	return total_dmg
	pass	
	
#----------------------------
############# ATTACK	
#----------------------------	

func enable_weapon_collision(isMonotoring: bool) -> void:
	enemy_attack_area.monitoring = isMonotoring
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
	
	
	
	
		
#region signal observers

func _on_health_on_death() -> void:
	queue_free()
	pass 


func _on_health_on_health_changed(current_health: float) -> void:
	EventBus.on_player_health_updated.emit(current_health, health.max_health)
	pass

func _on_mana_on_mana_changed(current_mana: float) -> void:
	EventBus.on_player_mana_updated.emit(current_mana, mana.max_mana)
	pass
#endregion
