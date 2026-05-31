extends Node

signal on_dialogue_started(dialogue: DialogueResource)
signal on_dialogue_finished

var is_active: bool = false
