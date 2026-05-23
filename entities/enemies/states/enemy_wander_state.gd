class_name EnemyWanderState extends EnemyState


@export var min_move_speed: float = 20.0
@export var max_move_speed: float = 20.0
@export var arrival_distance: float = 20.0

var target_position: Vector2

func enter_state() -> void:
	_pick_new_target()
	pass
	
func process_state(delta: float) -> void:
	if not enemy: return
	
	#move to target
	var direction = enemy.global_position.direction_to(target_position)	
	var speed = randf_range(min_move_speed, max_move_speed)
	enemy.global_position += direction * speed * delta
	
	#update animation
	enemy.update_animation(direction)
	
	#check arrive at destination
	
	if enemy.global_position.distance_to(target_position) < arrival_distance: #arrived
		_pick_new_target()
	
	pass	
	
func _pick_new_target() -> void:
	if enemy and enemy.enemy_zone:
		target_position = enemy.enemy_zone._get_random_spawn_position()
		
	
