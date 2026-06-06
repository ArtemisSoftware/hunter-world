class_name ShopPanel extends Control


@export var items: Array[ItemRes]

@onready var grid_container: GridContainer = $Panel/MarginContainer/VBoxContainer/GridContainer
@onready var total_coins: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/TotalCoins


func _ready() -> void:
	
	for button in grid_container.get_children():
		button.queue_free()
	
	_load_shop_items()
	total_coins.text = str(EventBus.coins)
	pass 

func _load_shop_items() -> void:
	
	for item: ItemRes in items:
		var shop_button: ShopButton = ShopGlobal.SHOP_BUTTON.instantiate()
		grid_container.add_child(shop_button)
		shop_button.load_item(item)
		shop_button.on_item_purchased.connect(_on_item_purchased)
	pass		

func _on_item_purchased() -> void:
	
	total_coins.text = str(EventBus.coins)
	pass


func _on_close_button_pressed() -> void:
	hide()
	pass # Replace with function body.
