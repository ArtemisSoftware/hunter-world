class_name Town extends Node2D

@export var player_scene: PackedScene

func _ready() -> void:
	_create_player()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _create_player() -> void:
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.set_up()
	EventBus.on_player_created.emit()
	pass
