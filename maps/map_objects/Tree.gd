extends Sprite


onready var STICK_SCENE = preload("res://items/Stick.tscn")


func _on_InteractionArea_area_entered(area):
	$AnimatedSprite.visible = true

func _on_InteractionArea_area_exited(area):
	$AnimatedSprite.visible = false

func interact(held_item):
	if held_item == null:
		return STICK_SCENE.instance()
	else:
		return held_item
