class_name QuestPanel extends Control


@onready var quest_container: VBoxContainer = $Panel/MarginContainer/VBoxContainer/ScrollContainer/QuestContainer

@export var quests: Array[QuestResource]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in quest_container.get_children():
		button.queue_free()
		
	_create_quest_buttons()	
	pass # Replace with function body.

func _create_quest_buttons() -> void:
	for quest: QuestResource in quests:
		var btn: QuestButton = QuestGlobal.QUEST_BUTTON.instantiate()
		quest_container.add_child(btn)
		btn.setup(quest)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass


func _on_close_button_pressed() -> void:
	hide()
	pass # Replace with function body.
