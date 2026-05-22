class_name Mana extends Node

var current_mana: float
var _max_mana: float

signal on_mana_changed(current_mana: float)


func setup(value: float) -> void:
	_max_mana = value
	current_mana = value
	pass
	

func use_mana(value: float) -> void:
	if current_mana <= 0:
		return
		
	current_mana = max(current_mana - value, 0)
	on_mana_changed.emit(current_mana)
	pass	
	
func add_mana(value: float) -> void:	
	current_mana = min(current_mana + value, _max_mana)
	on_mana_changed.emit(current_mana)
	pass		
