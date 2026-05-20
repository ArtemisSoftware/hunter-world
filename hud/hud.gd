class_name  Hud extends CanvasLayer

@onready var loadout: HBoxContainer = $Loadout
@onready var loadout_bar: Panel = $LoadoutBar
@onready var player_hud: HBoxContainer = $PlayerHud
@onready var grabbed_slot: Slot = $GrabbedSlot


func _ready() -> void:
	EventBus.on_player_health_updated.connect(_on_player_health_updated)
	EventBus.on_player_mana_updated.connect(_on_player_mana_updated)
	EventBus.on_player_new_level.connect(_on_player_new_level)
	pass 


func _process(delta: float) -> void:
	pass


func _on_player_health_updated(current: float, max: float)-> void:
	player_hud.update_health(current, max)
	pass
	
func _on_player_mana_updated(current: float, max: float)-> void:
	player_hud.update_mana(current, max)
	pass	

func _on_player_new_level(current: float, new_level: float)-> void:
	player_hud.update_new_level(current, new_level)
	pass	

#---------------------
# SIGNALS
#---------------------

func _on_equipment_button_pressed() -> void:
	loadout.toggle_equipment()
	pass 


func _on_inventory_button_pressed() -> void:
	loadout.toggle_inventory()
	pass 


func _on_stats_button_pressed() -> void:
	loadout.toggle_stats()
	pass 


func _on_skills_button_pressed() -> void:
	loadout.toggle_skills()
	pass 
