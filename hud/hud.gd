class_name Hud extends CanvasLayer

@onready var loadout: HBoxContainer = $Loadout
@onready var loadout_bar: Panel = $LoadoutBar
@onready var player_hud: HBoxContainer = $PlayerHud
@onready var grabbed_slot: Slot = $GrabbedSlot

@onready var skill_bar: Panel = $SkillBar
@onready var shop_panel: Control = $ShopPanel
@onready var craft_panel: CraftPanel = $CraftPanel
@onready var quest_panel: QuestPanel = $QuestPanel


func _ready() -> void:
	HudGlobal.hud = self
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
	
func equip_skill_to_empty_slot(skill: SkillRes) -> void:
	
	for index in skill_bar.skill_hot_keys.size():
		var button: EquippedSkillButton = skill_bar.skill_hot_keys[index]
		if button.equipped_skill == null:
			button.equip_skill(skill)
			HudGlobal.skill_slots[index] = skill
			return
	pass


func open_npc_panel(type: Npc.NpcType) -> void:
	
	match type:
		Npc.NpcType.SHOP:
			shop_panel.show()
		Npc.NpcType.CRAFTING:
			craft_panel.show()	
		Npc.NpcType.QUEST:
			quest_panel.show()
	pass

#---------------------
# SIGNALS
#---------------------

func _on_equipment_button_pressed() -> void:
	loadout.toggle_equipment()
	
	SoundManager.play(Sound.BUTTON)
	pass 


func _on_inventory_button_pressed() -> void:
	loadout.toggle_inventory()
	SoundManager.play(Sound.BUTTON)
	pass 


func _on_stats_button_pressed() -> void:
	loadout.toggle_stats()
	SoundManager.play(Sound.BUTTON)
	pass 


func _on_skills_button_pressed() -> void:
	loadout.toggle_skills()
	SoundManager.play(Sound.BUTTON)
	pass 
