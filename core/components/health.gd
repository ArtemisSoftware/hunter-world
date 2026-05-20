class_name Health extends Node

var current_health: float
var max_health: float

signal on_health_changed(current_health: float)
signal on_death()


func setup(value: float) -> void:
	max_health = value
	current_health = value
	pass
	

func take_damage(value: float) -> void:
	if current_health <= 0:
		return
		
	current_health = max(current_health - value, 0)
	on_health_changed.emit(current_health)
	
	if current_health <= 0:
		on_death.emit()
	
	pass	
	

func heal(value: float) -> void:
	current_health = min(current_health + value, max_health)
	on_health_changed.emit(current_health)
	pass	
		
