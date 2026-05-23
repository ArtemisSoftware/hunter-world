class_name Enemy extends Area2D

@export var stats: EnemyStatsRes

@onready var selector: Sprite2D = $Selector
@onready var health: Health = $Health

@onready var fsm: FSM = $FSM
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


signal  on_death

var enemy_zone: EnemyZone

func _ready() -> void:
	health.setup(stats.max_health)
	pass 
	
func select_enemy() -> void:
	selector.show()
	pass	
	
func _process(delta: float) -> void:
	if fsm.current_state: fsm.current_state.process_state(delta)
	pass
	
func update_animation(direction: Vector2) -> void:
	
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite_2d.play("move_right")
		else:
			animated_sprite_2d.play("move_left")
	else:
		if direction.y > 0:
			animated_sprite_2d.play("move_down")
		else:
			animated_sprite_2d.play("move_up")		
			
	pass	
