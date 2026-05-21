extends Node

var equipment: Dictionary[String, EquipmentItem] = {
	"HELMET": null,
	"BODY": null,
	"LEGS": null,
	"WEAPON": null,
	"RING": null,
}


func get_equipment(equipment_type: EquipmentItem.EquipmentType):
	
	var key = equipment.keys()[equipment_type]
	var current_equipment = equipment[key]
	return {
		"key": key,
		"equipment":current_equipment
	}
	pass
	
func remove(key: String):
	equipment[key] = null
	pass	
