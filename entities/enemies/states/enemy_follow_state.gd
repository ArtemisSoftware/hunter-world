class_name EnemyFollowState extends EnemyState

@export var min_move_speed: float = 20.0
@export var max_move_speed: float = 35.0
@export var stop_distance: float = 15.0

func process_state(delta: float) -> void:
	if not enemy or not EventBus.player: return
	
	var direction = enemy.global_position.direction_to(EventBus.player.global_position)
	var distance = enemy.global_position.distance_to(EventBus.player.global_position)
	
	if distance > stop_distance:
		var speed = randf_range(min_move_speed, max_move_speed)
		enemy.global_position += direction * speed * delta
		enemy.update_animation(direction)
	pass
