class_name CraftPanel extends Control

@export var recipes: Array[RecipeResource]

@onready var recipies: GridContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Recipies
@onready var materials: VBoxContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials
@onready var recipe_icon: TextureRect = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/HBoxContainer/RecipeIcon
@onready var recipe_name: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/HBoxContainer/RecipeName

@onready var material_icon: TextureRect = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material1/MaterialIcon
@onready var material_name: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material1/MaterialName
@onready var needed: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material1/HBoxContainer/Needed
@onready var available: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material1/HBoxContainer/Available


@onready var material_2_icon: TextureRect = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material2/MaterialIcon
@onready var material_2_name: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material2/MaterialName
@onready var needed_2: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material2/HBoxContainer/Needed
@onready var available_2: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/Material2/HBoxContainer/Available

@onready var amount: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Materials/VBoxContainer/HBoxContainer/HBoxContainer/Amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	hide()
	pass # Replace with function body.
