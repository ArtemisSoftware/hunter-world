extends Node

signal on_inventory_changed
signal on_equipment_changed
signal on_inventory_used_item(item: ItemRes)

const INVENTORY_SIZE: int = 30

var inventory: Array[SlotRes]


func _ready() -> void:
	inventory.clear()
	inventory.resize(INVENTORY_SIZE)
	pass
	
#region use item	
	
func use_item(slot_index) -> void:
	
	var slot: SlotRes = inventory[slot_index]
	if not slot: return
	
	if not slot.item.is_consumable: return
	
	slot.quantity -= 1
	if slot.quantity <= 0:
		inventory[slot_index] = null
	
	on_inventory_changed.emit()	
	pass	
	
func can_use_item(slot_index) -> bool:
	
	var slot: SlotRes = get_slot(slot_index)
	return slot and slot.item.is_consumable
	pass	
	
#endregion		
	
#region find item		
func _get_empty_slot_indexes() -> Array[int]:
	var empty: Array[int] = []
	
	for index in inventory.size():
		if inventory[index] == null:
			empty.append(index)
			
	return empty		
	pass	
	
func _find_item_indexes(item: ItemRes, with_space: bool = false) -> Array[int]:
	var found: Array[int] = []
	
	for index in inventory.size():
		var slot = inventory[index]
		if slot and slot.item == item:
			if with_space:
				if slot.quantity < item.max_stack:
					found.append(index)
			else:
				found.append(index)
	return found
	pass	
	
	
func count_item(item: ItemRes) -> int:
	var total: int = 0
	for slot in inventory:
		if slot and slot.item == item:
			total += slot.quantity
	
	return total			
	pass
#endregion	

#region add / remove
	
func add_item(item: ItemRes, amount: int = 1) -> void:
	
	if not item:
		return
		
	var remaining = amount
	
	if item.max_stack > 1:
		for index in _find_item_indexes(item, true):
			if remaining <= 0:
				break
			
			var slot = inventory[index]
			var space = item.max_stack - slot.quantity
			var to_give = min(space, remaining)
			
			slot.quantity += to_give
			remaining -= to_give
			
	if remaining > 0:
		for index in _get_empty_slot_indexes():
			if remaining <= 0:
				break
				
			var to_give = min(item.max_stack, remaining)
			inventory[index] = SlotRes.new(item, to_give)
			remaining -= to_give
			
	var added = amount - remaining
	
	if added > 0:
		on_inventory_changed.emit()
	pass	
	
	
func get_slot(index: int) -> SlotRes:
	if index >= 0 and index < inventory.size():
		return inventory[index]
	return null
	pass	

#endregion

#region move slots
func swap_slots(from_index: int, to_index: int) -> void:
	if from_index < 0 or from_index >= inventory.size():
		return
		
	if to_index < 0 or to_index >= inventory.size():
		return
	
	var temp = inventory[from_index]	
	inventory[from_index] = inventory[to_index]
	inventory[to_index] = temp
	
	on_inventory_changed.emit()
	pass	
	
func merge_slots(from_index: int, to_index: int) -> void:
	
	var from_slot: SlotRes = get_slot(from_index)
	var to_slot: SlotRes = get_slot(to_index)
	
	if not from_slot or not to_slot:
		return
		
	if from_slot.item != to_slot.item:
		return
	
	var item = from_slot.item
	if item.max_stack <= 1:
		return
		
	var space = item.max_stack - to_slot.quantity
	var to_move = min(space, from_slot.quantity)
	
	to_slot.quantity += to_move
	from_slot.quantity -= to_move
	
	if from_slot.quantity <= 0:
		inventory[from_index] = null
	elif space <= 0:
		swap_slots(from_index, to_index)	
	
	on_inventory_changed.emit()
	pass		

#endregion

func get_slot_item(index: int) -> ItemRes:
	var slot = get_slot(index)
	
	if slot:
		return slot.item
		
	return null	
	pass


#region equipment

func equip_item(slot_index: int) -> void:
	var slot: SlotRes = get_slot(slot_index)
	
	if not slot: return
	
	if not slot.item is EquipmentItem: return
	
	var equipment: EquipmentItem = slot.item as EquipmentItem
	var equip_key: String = equipment.get_equipment_key()

	var current_equipped_item = EquipmentGlobal.equipment[equip_key] 
	EquipmentGlobal.equipment[equip_key] = equipment
	
	inventory[slot_index] = null
	if current_equipped_item:
		add_item(current_equipped_item, 1)
	
	on_inventory_changed.emit()
	on_equipment_changed.emit()
	pass
	
	
func unequip_item(equipment_type: EquipmentItem.EquipmentType) -> void:
	var result = EquipmentGlobal.get_equipment(equipment_type)
	
	if not result.equipment: return
	
	add_item(result.equipment) 
	EquipmentGlobal.remove(result.key)
	
	on_equipment_changed.emit()
	pass
	
#endregion
