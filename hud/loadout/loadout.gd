class_name Loadout extends HBoxContainer

@onready var inventory_panel: InventoryPanel = $InventoryPanel
@onready var equipment_panel: EquipmentPanel = $EquipmentPanel
@onready var stats_panel: StatsPanel = $StatsPanel
@onready var skills_panel: SkillsPanel = $SkillsPanel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func toggle_inventory() -> void:
	inventory_panel.visible = not inventory_panel.visible
	pass	
	
func toggle_equipment() -> void:
	equipment_panel.visible = not equipment_panel.visible
	pass	
	
func toggle_stats() -> void:
	stats_panel.visible = not stats_panel.visible
	pass	
	
func toggle_skills() -> void:
	skills_panel.visible = not skills_panel.visible
	pass				
