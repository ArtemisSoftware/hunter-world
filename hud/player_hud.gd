class_name PlayerHud extends HBoxContainer

@onready var health_bar: ProgressBar = %HealthBar
@onready var mana_bar: ProgressBar = %ManaBar
@onready var exp_bar: ProgressBar = %ExpBar
@onready var health_label: Label = %HealthLabel
@onready var mana_label: Label = %ManaLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_health(current: float, max: float)	 -> void:
	health_bar.value = current / max
	health_label.text = "%d / %d" % [current, max]
	pass
	
func update_mana(current: float, max: float)	 -> void:
	mana_bar.value = current / max
	mana_label.text = "%d / %d" % [current, max]
	pass	
	
func update_new_level(current: float, new_level: float)	 -> void:
	exp_bar.value = current / new_level
	pass		
