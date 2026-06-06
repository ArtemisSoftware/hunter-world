class_name CraftButton extends Button

@onready var item_icon: TextureRect = $ItemIcon

var recipe: RecipeResource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_data(recipe: RecipeResource) -> void:
	
	self.recipe = recipe
	item_icon.texture = recipe.crafted_item.icon
	pass
