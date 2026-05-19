class_name EquippedSkillButton extends Button

@onready var empty_panel: Panel = $EmptyPanel
@onready var label: Label = $Label
@onready var skill_icon: TextureRect = $SkillIcon



@export var index_number: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(index_number)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
