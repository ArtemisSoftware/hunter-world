class_name DialoguePanel extends Control

@onready var speaker_icon: TextureRect = $SpeakerIcon
#@onready var text: Label = $NinePatchRect/MarginContainer/Text
@onready var text: Label = %Text
@onready var speaker_name: Label = $NinePatchRect/MarginContainer/VBoxContainer/SpeakerName


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
	

func _input(event: InputEvent) -> void:
	if not visible: return
	
	if event.is_action_pressed("ui_accept"):
	#if event.is_action_pressed("interact") && DialogueGlobal.is_active: # TODO: I want to interact using keyboard
		get_viewport().set_input_as_handled()
		
		if is_typing:
			_complete_text_line()
		else:
			_next_text_line()	
		
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
		
	_show_speaker_name()
	text.text = current_dialogue.text[current_line_index]
	
	text.visible_characters = 0
	is_typing = true
	
	if tween:
		tween.kill()
	tween = create_tween()
	
	var duration = text.text.length() * typing_speed
	tween.tween_property(text, "visible_characters", text.text.length(), duration)
	tween.finished.connect(func(): is_typing = false)
	pass
	
func _show_speaker_name() -> void:
	speaker_name.text = current_dialogue.speaker_name
	pass	
	
func _complete_text_line() -> void:
	if tween: tween.kill()
	
	text.visible_characters = -1
	is_typing = false
	pass
	
func _next_text_line() -> void:
	current_line_index += 1
	_show_line()
	pass		
	
func _end_dialogue() ->	 void:
	hide()
	current_dialogue = null
	DialogueGlobal.on_dialogue_finished.emit()
	DialogueGlobal.is_active = false
	pass
	
