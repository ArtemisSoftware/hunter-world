class_name StatsPanel extends PanelContainer

@onready var damage_label: Label = %DamageLabel
@onready var velocity_label: Label = %VelocityLabel
@onready var critical_label: Label = %CriticalLabel
@onready var hp_label: Label = %HpLabel
@onready var mana_label: Label = %ManaLabel
@onready var critical_damage_label: Label = %CriticalDamageLabel

@onready var current_level_label: Label = %CurrentLevelLabel
@onready var current_points_label: Label = %CurrentPointsLabel

@onready var strength_points_label: Label = %StrengthPointsLabel
@onready var dexterity_points_label: Label = %DexterityPointsLabel
@onready var inteligence_points_label: Label = %InteligencePointsLabel

@onready var strength_button: Button = %StrengthButton
@onready var dexterity_button: Button = %DexterityButton
@onready var inteligence_button: Button = %InteligenceButton

func _ready() -> void:
	EventBus.on_player_created.connect(_on_player_created)
	EventBus.on_player_stats_updated.connect(_on_player_stats_updated)
	pass

func update_stats() -> void:
	if not is_instance_valid(EventBus.player): return
		
	damage_label.text = str(EventBus.player.stats.damage)
	hp_label.text = str(EventBus.player.stats.max_health)
	
	velocity_label.text = str(EventBus.player.stats.move_speed)
	mana_label.text = str(EventBus.player.stats.max_mana)
	critical_damage_label.text = str(EventBus.player.stats.critical_damage)
	critical_label.text = str(EventBus.player.stats.critical_chance)
	
	current_level_label.text = str(EventBus.player.exp.current_level)
	current_points_label.text = str(EventBus.player.exp.current_points)
	
	strength_points_label.text = str(EventBus.player.stats.strength)
	dexterity_points_label.text = str(EventBus.player.stats.dexterity)
	inteligence_points_label.text = str(EventBus.player.stats.intelligence)
	
	if EventBus.player.exp.current_points == 0:
		strength_button.hide()
		dexterity_button.hide()
		inteligence_button.hide()
	else:
		strength_button.show()
		dexterity_button.show()
		inteligence_button.show()	
	
	pass
	
func _on_player_created() -> void:
	update_stats()
	pass	
	
func _on_player_stats_updated() -> void:
	update_stats()
	pass		
	

func _on_strength_button_pressed() -> void:
	EventBus.player.stats.upgrade_stat(Stats.Type.STRENGHT)
	pass 


func _on_dexterity_button_pressed() -> void:
	EventBus.player.stats.upgrade_stat(Stats.Type.DEXTERITY)
	pass 


func _on_inteligence_button_pressed() -> void:
	EventBus.player.stats.upgrade_stat(Stats.Type.INTELLINGENCE)
	pass
