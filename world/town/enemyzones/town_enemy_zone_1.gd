class_name EnemyZone extends Area2D


@export var enemy_scene: PackedScene
@export var spawn_rate: float = 3.0
@export var max_enemies: int = 1

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var current_enemies: int = 0

func _ready() -> void:
	timer.wait_time = spawn_rate
	pass


func _spawn_enemy() -> void:
	
	if current_enemies >= max_enemies: return
	
	var spawn_position = _get_random_spawn_position()
	
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_position
	enemy.on_death.connect(_on_death)
	enemy.enemy_zone = self
	get_tree().root.add_child(enemy)
	current_enemies += 1
	pass
	
	
func _get_random_spawn_position() -> Vector2:
	
	var shape = collision_shape_2d.shape as RectangleShape2D
	var half_size = shape.size / 2
	var random_posititon = Vector2(
		randf_range(-half_size.x, half_size.x),
		randf_range(-half_size.y, half_size.y),
	)
	
	return collision_shape_2d.global_position + random_posititon
	pass	
	
func _on_death() -> void:
	current_enemies = max(current_enemies - 1, 0)
	pass


func _on_timer_timeout() -> void:
	_spawn_enemy()
	pass 
