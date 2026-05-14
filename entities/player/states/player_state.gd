class_name PlayerState extends State

var player: Player

func _ready() -> void:
	
	await owner.ready #to avoid errors if a scene or a node is not loaded
	player = owner as Player
	
	pass
