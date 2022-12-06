extends Node2D


onready var orders = [
	"coal",
	"copper",
	"copper",
	"iron",
	"coal",
	"iron",
	"coal",
	"iron",
	"copper",
	"iron",
]


func _ready():
	$ItemBubble.play(orders.front())


func end_game():
	$ItemBubble.visible = false
	var result = 0
	var timer = get_parent().get_parent().get_node("timer")
	if timer.time < 180:			# Time to get 3 stars
		result = 3
	elif timer.time < 240:			# Time to get 2 stars
		result = 2
	else:
		result = 1
	get_tree().get_root().get_node("Main").end_level(result)


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
