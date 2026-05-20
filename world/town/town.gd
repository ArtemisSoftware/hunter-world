class_name Town extends Node2D

@export var player_scene: PackedScene

func _ready() -> void:
	InventoryGlobal.on_inventory_used_item.connect(_on_inventory_used_item) #TODO: isto não deveria ser no player ou no hud??????
	_create_player()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _create_player() -> void:
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.set_up()
	EventBus.player = player
	EventBus.on_player_created.emit()
	pass
	
func _on_inventory_used_item(item: ItemRes) -> void:
	
	match item.id:
		ItemRes.Identifier.HEALTH_POTION: EventBus.player.health.heal(item.value)
		ItemRes.Identifier.MANA_POTION: EventBus.player.mana.add_mana(item.value)			
	pass	
