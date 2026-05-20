extends Node

signal on_inventory_changed
signal on_equipment_changed

const INVENTORY_SIZE: int = 30

var inventory: Array[SlotRes]


func _ready() -> void:
	inventory.clear()
	inventory.resize(INVENTORY_SIZE)
	pass
	
#testing	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		add_item(preload("uid://cnhathoc7pkm3"), 10)
	pass	
	
func get_empty_slot_indexes() -> Array[int]:
	var empty: Array[int] = []
	
	for index in inventory.size():
		if inventory[index] == null:
			empty.append(index)
			
	return empty		
	pass	
	
func find_item_indexes(item: ItemRes, with_space: bool = false) -> Array[int]:
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
	
func add_item(item: ItemRes, amount: int = 1) -> void:
	
	if not item:
		return
		
	var remaining = amount
	
	if item.max_stack > 1:
		for index in find_item_indexes(item, true):
			if remaining <= 0:
				break
			
			var slot = inventory[index]
			var space = item.max_stack - slot.quantity
			var to_give = min(space, remaining)
			
			slot.quantity += to_give
			remaining -= to_give
			
	if remaining > 0:
		for index in get_empty_slot_indexes():
			if remaining <= 0:
				break
				
			var to_give = min(item.max_stack, remaining)
			inventory[index] = SlotRes.new(item, to_give)
			remaining -= to_give
			
	var added = amount - remaining
	
	if added > 0:
		on_inventory_changed.emit()
	pass	
