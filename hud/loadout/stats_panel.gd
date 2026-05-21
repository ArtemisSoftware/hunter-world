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

func _ready() -> void:
	EventBus.on_player_created.connect(_on_player_created)
	pass

func update_stats() -> void:
	if not is_instance_valid(EventBus.player): return
	
	damage_label.text = str(EventBus.player.damage)
	hp_label.text = str(EventBus.player.health.max_health)
	velocity_label.text = str(EventBus.player.move_speed)
	mana_label.text = str(EventBus.player.mana.max_mana)
	critical_damage_label.text = str(EventBus.player.critical_damage)
	critical_label.text = str(EventBus.player.critical_chance)
	
	current_level_label.text = str(EventBus.player.exp.current_level)
	current_points_label.text = str(EventBus.player.current_points)
	
	
	strength_points_label.text = str(EventBus.player.stats.strength)
	dexterity_points_label.text = str(EventBus.player.stats.dexterity)
	inteligence_points_label.text = str(EventBus.player.stats.intelligence)
	
	pass
	
func _on_player_created() -> void:
	update_stats()
	pass	
	

func _on_strength_button_pressed() -> void:
	pass # Replace with function body.


func _on_dexterity_button_pressed() -> void:
	pass # Replace with function body.


func _on_inteligence_button_pressed() -> void:
	pass # Replace with function body.
