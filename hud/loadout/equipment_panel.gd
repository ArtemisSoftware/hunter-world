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
	
func _on_equipment_changed() -> void:
	
	pass	
	
func _on_slot_pressed(slot: EquipmentSlot) -> void:
	
	pass		
