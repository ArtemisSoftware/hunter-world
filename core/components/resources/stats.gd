class_name Stats extends Resource

@export var strength: int = 0
@export var dexterity: int = 0
@export var intelligence: int = 0

@export var damage: float = 1.0

@export var max_health: float = 5.0
@export var max_mana: float = 0.0

@export var critical_chance: float = 0.0
@export var critical_damage: float = 0.0

@export var move_speed: float = 60.0

signal on_stat_upgrade(type: Type)

enum Type {
	STRENGHT,
	DEXTERITY,
	INTELLINGENCE
}

func upgrade_stat(type: Type) -> void:
	
	match type:
		Type.STRENGHT:
			strength += 1
			damage += 1.5
			max_health += 3.0
			
		Type.DEXTERITY:
			dexterity += 1
			move_speed += 2.0
			critical_chance += 2.0
			
		Type.INTELLINGENCE:
			intelligence += 1
			critical_damage +=	5
			max_mana += 2.0
	
	on_stat_upgrade.emit(type)
	pass
