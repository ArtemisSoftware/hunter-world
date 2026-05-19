class_name LootDrop extends Area2D


@export var item: InventoryItem
@export var amount: int = 1
@export var shine_speed: float = 0.6
@export var shine_frequency: float = 2.0

@onready var item_icon: Sprite2D = $ItemIcon

func _ready() -> void:
	_set_up()
	_shine()
	pass

func _set_up() -> void:
	if item and item.icon:
		item_icon.texture = item.icon
	pass 


func _load_item(slot: SlotRes) -> void:
	item = slot.item
	amount = slot.quantity
	pass 

func _shine() -> void:
	var shine_tween := create_tween().set_loops()
	shine_tween.tween_property(item_icon.material, "shader_parameter/shine_progress", 1.0, shine_speed).set_delay(shine_frequency)
	shine_tween.tween_property(item_icon.material, "shader_parameter/shine_progress", 0.0, shine_speed).set_delay(0.0)
	
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
