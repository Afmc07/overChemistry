extends Sprite


onready var IRON_SCENE = preload("res://items/IronOre.tscn")


func interact(held_item):
	if held_item == null:
		return IRON_SCENE.instance()
	else:
		return held_item
