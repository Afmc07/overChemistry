extends Sprite

onready var STICK_SCENE = preload("res://items/Stick.tscn")

onready var animated_sprite = $AnimatedSprite


func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = true


func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = false


func interact(held_item):
	if held_item == null:
		return STICK_SCENE.instance()
	else:
		return held_item
