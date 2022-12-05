extends Sprite


onready var IRON_SCENE = preload("res://items/IronOre.tscn")

onready var animated_sprite = $ItemBubble

func _on_Interaction_Area_area_entered(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = true


func _on_Interaction_Area_area_exited(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = false


func _ready():
	animated_sprite.play("ironore-z")


func interact(held_item):
	if held_item == null:
		return IRON_SCENE.instance()
	else:
		return held_item
