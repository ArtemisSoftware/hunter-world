class_name CraftPanel extends Control

@export var recipes: Array[RecipeResource]

@onready var available_recipies: GridContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer/AvailableRecipies
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


var amount_selected: int = 1
var button_selected: CraftButton


func _ready() -> void:
	materials.hide()
	for button in available_recipies.get_children():
		button.queue_free()
		
	_create_craft_recipes()	
	pass


func _create_craft_recipes() -> void:

	for recipe: RecipeResource in recipes:
		var btn: CraftButton = CraftGlobal.CRAFT_BUTTON.instantiate()
		btn.pressed.connect(_on_button_pressed.bind(btn))
		available_recipies.add_child(btn)
		btn.load_data(recipe)
	

	pass
	
func _update_material_information() -> void:
	recipe_icon.texture = button_selected.recipe.crafted_item.icon
	recipe_name.text = button_selected.recipe.crafted_item.name
	amount.text = str(amount_selected)
	
	var material_1 = button_selected.recipe.recipe_materials[0]
	material_icon.texture = material_1.item.icon
	material_name.text = material_1.item.name
	
	var required_1: int = material_1.amount * amount_selected
	
	needed.text = str(required_1)
	available.text = str(InventoryGlobal.count_item(material_1.item))
	
	
	var material_2 = button_selected.recipe.recipe_materials[1]
	material_2_icon.texture = material_2.item.icon
	material_2_name.text = material_2.item.name
	
	var required_2: int = material_2.amount * amount_selected
	
	needed_2.text = str(required_2)
	available_2.text = str(InventoryGlobal.count_item(material_2.item))
	
	pass	
	
func _on_button_pressed(craft_button: CraftButton) -> void:
	if not materials.visible:
		materials.show()
		
		
	button_selected = craft_button
	amount_selected = 1
	_update_material_information()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	hide()
	available_recipies.hide()
	pass # Replace with function body.
