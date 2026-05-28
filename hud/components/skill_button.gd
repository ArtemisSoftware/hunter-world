class_name SkillButton extends Button

@export var is_free: bool
@export var skill_info: SkillRes

@onready var lock: TextureRect = $Lock
@onready var skill_icon: TextureRect = $SkillIcon

var skill: SkillRes
var is_unlocked: bool

func _ready() -> void:
	enable_skill(false)
	
	if skill_info: _load_data(skill_info)
	if is_free: 
		is_unlocked = true
		enable_skill(true)
	pass

func _load_data(skill: SkillRes) -> void:
	
	self.skill = skill
	skill_icon.texture = skill_info.icon
	pass

func enable_skill(value: bool) -> void:
	skill_icon.modulate = Color.WHITE if value else Color("787878")
	lock.visible = not value
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	
	if not is_unlocked:
		if EventBus.coins >= skill.price:
			EventBus.coins -= skill.price
			is_unlocked = true
			enable_skill(true)
	else:
		HudGlobal.hud.equip_skill_to_empty_slot(skill)		
	
	pass
