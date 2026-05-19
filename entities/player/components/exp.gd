class_name Experience extends Node

var current_exp: float = 0.0
var next_level_exp: float
var current_level: int = 1
var current_points: int = 0
var exp_multiplier: float


signal on_next_level(current_exp: float, next_level_exp: float)
signal on_experience_updated

func setup(base_exp: float, multiplier: float) -> void:
	next_level_exp = base_exp
	exp_multiplier = multiplier
	pass
	
func add_exp(value: float) -> void:
	current_exp += value
	
	while current_exp >= next_level_exp:
		_level_up()
		
	on_next_level.emit(current_exp, next_level_exp)	
	pass		

func _level_up() -> void:
	current_exp -= next_level_exp
	current_level += 1
	current_points += 4
	next_level_exp *= exp_multiplier
	on_experience_updated.emit()	
	pass	
	
	
