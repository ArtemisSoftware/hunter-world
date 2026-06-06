class_name ShopButton extends Button

@onready var item_icon: TextureRect = $ItemIcon
@onready var price: Label = $HBoxContainer/Price


signal on_item_purchased


var item: ItemRes

func load_item(item: ItemRes) -> void:
	self.item = item
	item_icon.texture = item.icon
	price.text = str(item.price)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	
	if EventBus.coins < item.price: return
	EventBus.coins -= item.price
	InventoryGlobal.add_item(item)
	on_item_purchased.emit()
	pass 
