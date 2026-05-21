class_name EquipmentSlot extends Button

@onready var item_icon: TextureRect = $ItemIcon

@export var equipment_type: EquipmentItem.EquipmentType

var equipped_item: EquipmentItem

func _ready() -> void:
	_clear_slot()
	pass

func load_data(equipment: EquipmentItem) -> void:
	
	equipped_item = equipment
	
	if equipment:
		item_icon.texture = equipment.icon
		item_icon.show()
	else:	
		_clear_slot()
	pass
	
func _clear_slot() -> void:
	equipped_item = null
	if item_icon: item_icon.hide()
	pass	
