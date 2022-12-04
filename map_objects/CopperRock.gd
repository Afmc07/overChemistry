extends Sprite


onready var COPPER_SCENE = preload("res://items/CopperOre.tscn")


func interact(held_item):
	if held_item == null:
		return COPPER_SCENE.instance()
	else:
		return held_item
