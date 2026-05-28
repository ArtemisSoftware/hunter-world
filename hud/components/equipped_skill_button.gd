class_name EquippedSkillButton extends Button

@onready var empty_panel: Panel = $EmptyPanel
@onready var label: Label = $Label
@onready var skill_icon: TextureRect = $SkillIcon



@export var index_number: int = 0

var equipped_skill: SkillRes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(index_number)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func equip_skill(equipped_skill: SkillRes) -> void:
	self.equipped_skill = equipped_skill
	empty_panel.hide()
	skill_icon.texture = equipped_skill.icon
	skill_icon.show()
	pass
	
func reset_skill() -> void:
	empty_panel.show()
	skill_icon.hide()
	pass	

func _on_pressed() -> void:
	
	if equipped_skill: 
		HudGlobal.skill_slots[index_number - 1] = null
		equipped_skill = null
		reset_skill()
	
	pass
