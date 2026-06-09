class_name EnemyAttackState extends EnemyState

@export var attack_duration: float = 0.5

var attack_timer: float = 0.0
var damage_applied: bool = false


func enter_state() -> void:
	attack_timer = attack_duration
	damage_applied = false
	pass
	
func process_state(delta: float) -> void:
	
	if not enemy or not EventBus.player:
		fsm.transition_to("Wander")
		return
		
	attack_timer -= delta
	
	if attack_timer <= attack_timer / 2.0 and not damage_applied:
		apply_damage()	
		damage_applied = true
		
	if attack_timer <= 0.0:
		fsm.transition_to("Follow")	
	pass	
	
func apply_damage() -> void:
	var distance = enemy.global_position.distance_to(EventBus.player.global_position)
	
	if distance <= 25.0:
		EventBus.player.health.take_damage(enemy.stats.damage)
		EffectsGlobal.create_damage_fx(EventBus.player.global_position)
		EffectsGlobal.create_damage_text(EventBus.player.global_position, enemy.stats.damage)
		SoundManager.play(Sound.IMPACT)
	pass	
