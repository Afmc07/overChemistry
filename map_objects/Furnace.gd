extends Sprite

onready var furnace_status = "empty"

onready var COPPER_SCENE = preload("res://items/Copper.tscn")
onready var IRON_SCENE = preload("res://items/Iron.tscn")
onready var animated_sprite = $ItemBubble

var furnace_with_copper_metal = preload("res://assets/map_objects/furnace/furnace-copper-metal.png")
var furnace_with_copper_ore_and_coal = preload("res://assets/map_objects/furnace/furnace-copper-ore-coal.png")
var furnace_with_copper_ore = preload("res://assets/map_objects/furnace/furnace-copper-ore.png")
var lit_furnace = preload("res://assets/map_objects/furnace/furnace-fire.png")
var furnace_with_iron_metal = preload("res://assets/map_objects/furnace/furnace-iron-metal.png")
var furnace_with_iron_ore_and_coal = preload("res://assets/map_objects/furnace/furnace-iron-ore-coal.png")
var furnace_with_iron_ore = preload("res://assets/map_objects/furnace/furnace-iron-ore.png")
var empty_furnace = preload("res://assets/map_objects/furnace/furnace.png")


func _ready():
	animated_sprite.play("ore-z")


func _on_Interaction_Area_area_entered(area):
	if area.is_in_group("Player"):
		if player_is_holding_ore() and furnace_status == "empty":
			play_animation("ore-z")
		
		if furnace_status == "with_copper_ore" or furnace_status == "with_iron_ore":
			play_animation("coal-z")
		
		if furnace_status == "with_copper_coal" or furnace_status == "with_iron_coal":
			play_animation("fire-z")
		
		if furnace_status == "with_copper":
			play_animation("copper-z")
		
		if furnace_status == "with_iron":
			play_animation("iron-z")


func player_is_holding_ore():
	var player_held_item = get_parent().get_node("Player").get("held_item")
	if player_held_item != null:
		return is_ore(player_held_item)
	return false


func is_ore(player_held_item):
	var item_name = player_held_item.name.to_lower()
	return item_name.begins_with("copperore") or item_name.begins_with("ironore")


func play_animation(animation):
	animated_sprite.play(animation)
	animated_sprite.visible = true


func _on_Interaction_Area_area_exited(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = false


func _on_Timer_timeout():
	if furnace_status == "with_copper_coal_lit":
		get_node(".").set_texture(furnace_with_copper_metal)
		furnace_status = "with_copper"
		play_animation("copper-z")
	
	elif furnace_status == "with_iron_coal_lit":
		furnace_status = "with_iron"
		get_node(".").set_texture(furnace_with_iron_metal)
		play_animation("iron-z")


func interact(held_item):
	if held_item != null:
		if furnace_status == "empty" and is_ore(held_item):
			put_ore(held_item)
			return null

		if has_ore() and held_item.name.to_lower().begins_with("coal"):
			put_coal()
			return null

	elif $Timer.is_stopped():
		if furnace_status == "with_copper_coal" or furnace_status == "with_iron_coal":
			start_fire()
			return null

		elif furnace_status == "with_copper":
			get_metal()
			return COPPER_SCENE.instance()

		elif furnace_status == "with_iron":
			get_metal()
			return IRON_SCENE.instance()
	
	return held_item

func put_ore(held_item):
	var item_name = held_item.name.to_lower()
	animated_sprite.play("coal-z")

	if item_name.begins_with("copperore"):
		get_node(".").set_texture(furnace_with_copper_ore)
		furnace_status = "with_copper_ore"
		
	elif item_name.begins_with("ironore"):
		get_node(".").set_texture(furnace_with_iron_ore)
		furnace_status = "with_iron_ore"


func has_ore():
	return furnace_status == "with_copper_ore" or furnace_status == "with_iron_ore"


func put_coal():
	animated_sprite.play("fire-z")
	if furnace_status == "with_copper_ore":
		get_node(".").set_texture(furnace_with_copper_ore_and_coal)
		furnace_status = "with_copper_coal"
	
	elif furnace_status == "with_iron_ore":
		get_node(".").set_texture(furnace_with_iron_ore_and_coal)
		furnace_status = "with_iron_coal"
	

func start_fire():
	get_node(".").set_texture(lit_furnace)
	if furnace_status == "with_copper_coal":
		furnace_status = "with_copper_coal_lit"
	elif furnace_status == "with_iron_coal":
		furnace_status = "with_iron_coal_lit"
	$Timer.start()
	animated_sprite.visible = false


func get_metal():
	get_node(".").set_texture(empty_furnace)
	furnace_status = "empty"
	animated_sprite.visible = false
