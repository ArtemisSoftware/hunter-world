class_name EquipmentItem extends InventoryItem

enum EquipmentType {
	HELMET,
	BODY, 
	LEGS,
	WEAPON,
	RING
}

@export var equipment_type: EquipmentType
@export var bonus_damage: float = 0.0

func _init() -> void:
	type = Type.EQUIPMENT
	max_stack = 1
	pass
	
func get_equipment_key() -> String:
	match equipment_type:
		EquipmentType.HELMET: return "HELMET"
		EquipmentType.BODY: return "BODY"
		EquipmentType.LEGS: return "LEGS"
		EquipmentType.WEAPON: return "WEAPON"
		EquipmentType.RING: return "RING"
	return ""
			
