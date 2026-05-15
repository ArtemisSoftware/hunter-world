class_name PlayerStateIdle extends PlayerState


func enter_state() -> void:
	player.play_direction_animation("idle")
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		fsm.transition_to("Attack")
		return
	
	if player.is_moving():
		fsm.transition_to("Walk")
		return
	pass
