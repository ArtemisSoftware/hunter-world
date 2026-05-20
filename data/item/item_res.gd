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
}
