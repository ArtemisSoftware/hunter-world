class_name Portal extends Area2D

@export var target_position: Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	await Transition.fade_in(1.0)
	EventBus.player.global_position = target_position.global_position
	
	Transition.fade_out(1.0)
	pass 
