extends Node

var sound_dictionary: Dictionary = {
	Sound.BUTTON: preload("uid://bsgwhty5w3n4s"),
	Sound.IMPACT: preload("uid://ddiy74x8ihs81"),
	Sound.SKILL_HIT: preload("uid://bn7twkvclrfcn"),
	Sound.PICKUP: preload("uid://c5rxlslu4b6yt")
}

@export var stream_players: Array[AudioStreamPlayer]

func play(type: int) -> void:
	var stream_player = get_free_stream_player()
	
	if not stream_player: return
	
	
	var audio = sound_dictionary[type]
	stream_player.stream = audio
	stream_player.pitch_scale = randf_range(0.8, 1.2)
	stream_player.play()
	pass

func get_free_stream_player() -> AudioStreamPlayer:
	
	for stream in stream_players:
		if not stream.playing:
			return stream
			
	return null		
	pass
