class_name QuestButton extends Button

@onready var quest_name: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/QuestName
@onready var quest_description: Label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/QuestDescription
@onready var reward_icon: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/RewardIcon
@onready var progress: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Progress
@onready var complete: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Complete

var quest: QuestResource
var current_progress: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestGlobal.on_quest_progress_updated.connect(_on_quest_progress_updated)
	pass # Replace with function body.

func _on_quest_progress_updated(id: String, amount: int) -> void:
	if quest and quest.id == id:
		if current_progress < quest.target_value:
			current_progress += amount
			_update_progress()
	pass
	
func setup(quest: QuestResource) -> void:
	self.quest = quest
	quest_name.text = quest.name
	quest_description.text = quest.description
	reward_icon.texture = quest.reward.icon
	_update_progress()
	pass	
	
func _update_progress() -> void:
	if current_progress >= quest.target_value:
		current_progress = quest.target_value
		self_modulate = Color.GREEN
		
	progress.text = 	str(current_progress)
	complete.text = 	str(quest.target_value)
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if current_progress >= quest.target_value:
		InventoryGlobal.add_item(quest.reward)
		queue_free()
	pass # Replace with function body.
