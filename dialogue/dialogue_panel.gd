class_name DialoguePanel extends Control

@onready var speaker_icon: TextureRect = $SpeakerIcon
@onready var text: Label = $NinePatchRect/MarginContainer/Text


var current_dialogue: DialogueResource
var current_line_index: int = 0
var typing_speed: float = 0.03
var is_typing: bool = false
var tween: Tween


func _ready() -> void:
	hide()
	DialogueGlobal.on_dialogue_started.connect(_on_dialogue_started)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dialogue_started(dialogue: DialogueResource) -> void:
	current_dialogue = dialogue
	current_line_index = 0
	speaker_icon.texture = dialogue.speaker_icon
	show()
	_show_line()
	pass
	
func _show_line() ->	 void:
	if current_line_index >= current_dialogue.text.size():
		_end_dialogue()
		return
		
	var line: String = current_dialogue.text[current_line_index]
	text.text = current_dialogue.speaker_name + ":\n" + line
	
	text.visible_characters = 0
	is_typing = true
	
	if tween:
		tween.kill()
	tween = create_tween()
	
	var duration = text.text.length() * typing_speed
	tween.tween_property(text, "visible_characters", text.text.length(), duration)
	tween.finished.connect(func(): is_typing = false)
	pass
	
func _end_dialogue() ->	 void:
	hide()
	current_dialogue = null
	DialogueGlobal.on_dialogue_finished.emit()
	pass
	
