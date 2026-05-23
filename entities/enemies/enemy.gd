class_name Enemy extends Area2D

@export var stats: EnemyStatsRes

@onready var selector: Sprite2D = $Selector
@onready var health: Health = $Health

signal  on_death

var enemy_zone: EnemyZone

func _ready() -> void:
	health.setup(stats.max_health)
	pass 
	
func select_enemy() -> void:
	selector.show()
	pass	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
