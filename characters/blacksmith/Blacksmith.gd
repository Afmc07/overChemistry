extends Node2D


onready var orders = [
	"iron",
	"coal",
	"iron",
	"copper",
	"coal",
	"iron",
	"iron",
	"coal",
	"copper",
	"coal",
	"copper",
	"coal",
	"copper",
	"copper",
	"copper",
	"iron",
	"iron",
	"copper",
	"copper",
	"iron"
]


func _ready():
	$ItemBubble.play(orders.front())


func end_game():
	$ItemBubble.visible = false
	get_tree().get_root().get_node("Main").end_level()

func interact(held_item):
	if held_item != null:
		if held_item.name.to_lower() == orders.front():
			orders.pop_front()
			if orders.size() <= 0:
				end_game()
			else:
				$ItemBubble.play(orders.front())
			return null
	
	return held_item
