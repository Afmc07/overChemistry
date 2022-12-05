extends Sprite


onready var COPPER_SCENE = preload("res://items/Copper.tscn")
onready var IRON_SCENE = preload("res://items/Iron.tscn")

var furnace_with_copper_metal = preload("res://assets/map_objects/furnace/furnace-copper-metal.png")
var furnace_with_copper_ore_and_coal = preload("res://assets/map_objects/furnace/furnace-copper-ore-coal.png")
var furnace_with_copper_ore = preload("res://assets/map_objects/furnace/furnace-copper-ore.png")
var lit_furnace = preload("res://assets/map_objects/furnace/furnace-fire.png")
var furnace_with_iron_metal = preload("res://assets/map_objects/furnace/furnace-iron-metal.png")
var furnace_with_iron_ore_and_coal = preload("res://assets/map_objects/furnace/furnace-iron-ore-coal.png")
var furnace_with_iron_ore = preload("res://assets/map_objects/furnace/furnace-iron-ore.png")
var empty_furnace = preload("res://assets/map_objects/furnace/furnace.png")


onready var furnace_status = "empty"


func interact(held_item):
	print(furnace_status)
	if held_item != null:
		if held_item.name.to_lower().begins_with("coal"):
			if furnace_status == "empty":
				furnace_status = "with_coal"
				return null
			elif furnace_status == "with_copper_ore":
				furnace_status = "with_copper_coal"
				return null
			elif furnace_status == "with_iron_ore":
				furnace_status = "with_iron_coal"
				return null
		elif held_item.name.to_lower().begins_with("copperore"):
			if furnace_status == "empty":
				furnace_status = "with_copper_ore"
				return null
			elif furnace_status == "with_coal":
				furnace_status = "with_copper_coal"
				return null
		elif held_item.name.to_lower().begins_with("ironore"):
			if furnace_status == "empty":
				furnace_status = "with_iron_ore"
				return null
			elif furnace_status == "with_coal":
				furnace_status = "with_iron_coal"
				return null
	elif $Timer.is_stopped():
		if furnace_status == "with_copper_coal":
			$Timer.start()
			return null
		elif furnace_status == "with_iron_coal":
			$Timer.start()
			return null
		elif furnace_status == "with_copper":
			furnace_status = "empty"
			return COPPER_SCENE.instance()
		elif furnace_status == "with_iron":
			furnace_status = "empty"
			return IRON_SCENE.instance()
	
	return held_item


func _on_Timer_timeout():
	print("timeout")
	if furnace_status == "with_copper_coal":
		furnace_status = "with_copper"
	elif furnace_status == "with_iron_coal":
		furnace_status = "with_iron"
