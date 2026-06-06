class_name ItemRes extends Resource

@export var id: Identifier
@export var icon: Texture2D
@export var name: String
@export_multiline var description: String
@export var price: int

enum Identifier {
	HEALTH_POTION,
	MANA_POTION,
	EQUIPMENT_HELMET,
	EQUIPMENT_LEGS,
	EQUIPMENT_BODY,
	EQUIPMENT_WEAPON,
	EQUIPMENT_RING,
	FISH_FOOD,
	NUT_FOOD,
	MEAT_FOOD,
	HONEY_FOOD,
	SKILL_SHURIKEN,
	SKILL_ICE,
	SKILL_KUNAI,
	SKILL_ORB_PLANT,
	SKILL_ROCK_SPIKE,
	SKILL_THUNDER,
	SKILL_WATER_CANON,
	SKILL_WATER_SPLASH,
	SKILL_MAGIC_WEAPON,
	MEDIPACK
}
