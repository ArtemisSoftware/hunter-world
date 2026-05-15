class_name PlayerStateAttack extends PlayerState

var weapon_rotations: Dictionary = {
	"down": 180.0,
	"left": -90.0,
	"right": 90.0,
	"up": 0.0,
}

var attack_direction: String

func enter_state() -> void:
	attack_direction = player.last_direction
	player.play_direction_animation("attack")
	_position_weapon()
	player.animated_sprite_2d.animation_finished.connect(_on_animation_finished)
	pass
	
func _position_weapon() -> void:
	var marker: Marker2D = player.attack_positions[attack_direction]
	
	player.weapon.global_position = marker.global_position
	player.weapon.rotation_degrees = weapon_rotations[attack_direction]
	
	player.weapon.show()
	player.enable_weapon_collision(true)
	pass	
	
func exit_state() -> void:
	player.enable_weapon_collision(false)
	player.weapon.hide()
	
	if player.animated_sprite_2d.animation_finished.is_connected(_on_animation_finished):
		player.animated_sprite_2d.animation_finished.disconnect(_on_animation_finished)
	pass	
	
func _on_animation_finished() -> void:

	fsm.transition_to("Idle")
	pass
