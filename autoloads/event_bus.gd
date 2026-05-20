extends Node

signal on_player_created

signal on_player_health_updated(current: float, max: float)
signal on_player_mana_updated(current: float, max: float)

signal on_player_new_level(current_exp: float, new_level: float)
signal on_player_stats_updated

var player: Player
