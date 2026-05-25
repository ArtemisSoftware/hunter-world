extends Node

const DAMAGE_FX = preload("uid://dj58dgps5egp2")
const DAMAGE_TEXT = preload("uid://kkbwlyixu3mq")
const NEW_LEVEL_FX = preload("uid://dl677hjj71p64")

func create_damage_fx(position: Vector2) -> void:
	_create_fx_at_position(DAMAGE_FX, position)
	pass
	
func create_new_level_fx(position: Vector2) -> void:
	_create_fx_at_position(NEW_LEVEL_FX, position - Vector2(0, 7))
	pass	
	
func create_damage_text(position: Vector2, amount: float) -> void:
	var label: Label = DAMAGE_TEXT.instantiate()
	label.text = str(amount)
	label.global_position = position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4 #4 is the radius
	get_tree().root.add_child(label)
	
	var tween = create_tween()
	tween.tween_property(label, "global_position:y", label.global_position.y - 24, 0.7)
	tween.tween_callback(label.queue_free)
	pass
	
func _create_fx_at_position(scene: PackedScene, position: Vector2) -> void:
	
	var fx: AnimatedSprite2D = scene.instantiate()
	fx.global_position = position
	get_tree().root.add_child(fx)
	
	fx.animation_finished.connect(func(): fx.queue_free())
	pass		
