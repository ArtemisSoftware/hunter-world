class_name Enemy extends Area2D

@export var stats: EnemyStatsRes

@onready var selector: Sprite2D = $Selector
@onready var health: Health = $Health

@onready var fsm: FSM = $FSM
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar


signal on_death

var enemy_zone: EnemyZone

func _ready() -> void:
	health.setup(stats.max_health)
	health_bar.value = 1
	pass 
	
func select_enemy() -> void:
	selector.show()
	pass	
	
func deselect_enemy() -> void:
	selector.hide()
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


func _on_detect_area_2d_body_entered(body: Node2D) -> void:
	fsm.transition_to("Follow")
	
	pass # Replace with function body.


func _on_detect_area_2d_body_exited(body: Node2D) -> void:
	fsm.transition_to("Wander")
	pass # Replace with function body.


func _on_health_on_health_changed(current_health: float) -> void:
	health_bar.value = current_health / stats.max_health
	pass # Replace with function body.


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		EventBus.player.selected_enemy = self
	pass


func _on_health_on_death() -> void:
	on_death.emit()
	queue_free()
	pass # Replace with function body.
