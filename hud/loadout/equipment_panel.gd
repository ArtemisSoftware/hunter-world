class_name EquipmentPanel extends PanelContainer

@onready var slots: Array[EquipmentSlot] = [
	%HelmetSlot, 
	%BodySlot,
	%LegsSlot, 
	%WeaponSlot,   
	%RingSlot
]

func _ready() -> void:

	InventoryGlobal.on_equipment_changed.connect(_on_equipment_changed)
	
	for slot: EquipmentSlot in slots:
		slot.pressed.connect(_on_slot_pressed.bind(slot))
	
	pass
	
#region Observers

func _on_equipment_changed() -> void:
	var items: Array[EquipmentItem] = EquipmentGlobal.equipment.values()
	
	for index in slots.size():
		slots[index].load_data(items[index])
	
	pass	
	
func _on_slot_pressed(slot: EquipmentSlot) -> void:
	InventoryGlobal.unequip_item(slot.equipment_type)
	pass		
	
#endregion
