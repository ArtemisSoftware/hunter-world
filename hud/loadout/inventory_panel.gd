class_name InventoryPanel extends PanelContainer

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer
@onready var gold_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/GoldLabel

var slots: Array[Slot]

func _ready() -> void:
	InventoryGlobal.on_inventory_changed.connect(_on_inventory_changed)
	
	for index in grid_container.get_child_count():
		var slot: Slot = grid_container.get_child(index)
		slot.on_slot_clicked.connect(_on_slot_clicked)
		slot.on_slot_hovered.connect(_on_slot_hoverd)
		slot.slot_index = index
		slots.append(slot)
	pass
	
func _on_inventory_changed() -> void:
	for index in slots.size():
		var slot: SlotRes = InventoryGlobal.get_slot(index)
		slots[index].load_data(slot)
	pass	
	
	
func _on_slot_clicked() -> void:
	
	pass	
	
	
func _on_slot_hoverd() -> void:
	
	pass			
