class_name InventoryPanel extends PanelContainer

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer
@onready var gold_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/GoldLabel


@export var grabbed_slot: Slot

var slots: Array[Slot]
var selected_slot_index: int = -1

func _ready() -> void:
	InventoryGlobal.on_inventory_changed.connect(_on_inventory_changed)
	
	for index in grid_container.get_child_count():
		var slot: Slot = grid_container.get_child(index)
		slot.on_slot_clicked.connect(_on_slot_clicked)
		slot.on_slot_hovered.connect(_on_slot_hoverd)
		slot.slot_index = index
		slots.append(slot)
	pass
	
func _process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position()
	pass	
	
func _on_inventory_changed() -> void:
	for index in slots.size():
		var slot: SlotRes = InventoryGlobal.get_slot(index)
		slots[index].load_data(slot)
	pass	
	
func _select_slot(slot_index: int) -> void:
	_deselect_slot()
	selected_slot_index = slot_index
	
	var slot: SlotRes = InventoryGlobal.get_slot(selected_slot_index)
	grabbed_slot.load_data(slot)
	grabbed_slot.show()
	pass	
	
func _deselect_slot() -> void:
	selected_slot_index = -1
	grabbed_slot.hide()
	pass		
	
func _handle_left_button(slot_index: int) -> void:
	
	if selected_slot_index >= 0 and selected_slot_index != slot_index:
		var from_item = InventoryGlobal.get_slot_item(selected_slot_index)
		var to_item = InventoryGlobal.get_slot_item(slot_index)
		
		if from_item and to_item and from_item == to_item:
			InventoryGlobal.merge_slots(selected_slot_index, slot_index)
		else:
			InventoryGlobal.swap_slots(selected_slot_index, slot_index)	
			
		_deselect_slot()
	else:
		if selected_slot_index == slot_index:
			_deselect_slot()
		else:
			if InventoryGlobal.get_slot(slot_index):
				_select_slot(slot_index)
			
	pass	
	
func _handle_right_button(slot_index: int) -> void:
	
	pass		
	
#-------------------
#SIGNAL OBSERVERS
#-------------------	
	
	
func _on_slot_clicked(slot_index: int, button: int) -> void:
	
	match button:
		MOUSE_BUTTON_LEFT:
			_handle_left_button(slot_index)
		MOUSE_BUTTON_RIGHT:
			_handle_right_button(slot_index)	
	
	pass	
	
	
func _on_slot_hoverd(slot_index: int) -> void:
	
	pass			
