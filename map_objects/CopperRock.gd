extends Sprite


onready var COPPER_SCENE = preload("res://items/CopperOre.tscn")

onready var animated_sprite = $ItemBubble

func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = true


func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = false


func _ready():
	animated_sprite.play("copperore-z")


func interact(held_item):
	if held_item == null:
		return COPPER_SCENE.instance()
	else:
		return held_item


