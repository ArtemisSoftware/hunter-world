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
var material_1: RecipeMaterialResource
var material_1_requirement: int
var material_2: RecipeMaterialResource
var material_2_requirement: int


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
	
	material_1 = button_selected.recipe.recipe_materials[0]
	material_icon.texture = material_1.item.icon
	material_name.text = material_1.item.name
	
	material_1_requirement = material_1.amount * amount_selected
	
	needed.text = str(material_1_requirement)
	available.text = str(InventoryGlobal.count_item(material_1.item))
	
	
	material_2 = button_selected.recipe.recipe_materials[1]
	material_2_icon.texture = material_2.item.icon
	material_2_name.text = material_2.item.name
	
	material_2_requirement = material_2.amount * amount_selected
	
	needed_2.text = str(material_2_requirement)
	available_2.text = str(InventoryGlobal.count_item(material_2.item))
	
	pass	
	
func _on_button_pressed(craft_button: CraftButton) -> void:
	if not materials.visible:
		materials.show()
		
		
	button_selected = craft_button
	amount_selected = 1
	_update_material_information()
	SoundManager.play(Sound.BUTTON)
	pass


func _can_craft_recipe() -> bool:
	
	return InventoryGlobal.count_item(material_1.item) >= material_1_requirement and InventoryGlobal.count_item(material_2.item) >= material_2_requirement
		
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	hide()
	materials.hide()
	SoundManager.play(Sound.BUTTON)
	#available_recipies.hide()
	pass # Replace with function body.


func _on_remove_button_pressed() -> void:
	amount_selected -= 1
	amount_selected = max(1, amount_selected)
	_update_material_information()
	SoundManager.play(Sound.BUTTON)
	pass # Replace with function body.


func _on_add_button_pressed() -> void:
	amount_selected += 1
	_update_material_information()
	SoundManager.play(Sound.BUTTON)
	pass # Replace with function body.


func _on_craft_button_pressed() -> void:
	if _can_craft_recipe():
		InventoryGlobal.remove_item(material_1.item, material_1_requirement)
		InventoryGlobal.remove_item(material_2.item, material_2_requirement)
		InventoryGlobal.add_item(button_selected.recipe.crafted_item, amount_selected)
		
		amount_selected = 1
		_update_material_information()
	SoundManager.play(Sound.BUTTON)
	pass # Replace with function body.
