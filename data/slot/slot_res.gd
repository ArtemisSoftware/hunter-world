class_name SlotRes extends Resource

@export var item: InventoryItem
@export var quantity: int = 1

func _init(item: InventoryItem, quantity: int) -> void:
	
	self.item = item
	self.quantity = quantity
	pass
