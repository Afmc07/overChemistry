extends Sprite

var show_interaction_bubble = false
var hole_status = "empty"

var empty_hole = preload("res://assets/objects/hole/Hole.png")
var hole_with_sticks = preload("res://assets/objects/hole/HoleSticks.png")
var hole_with_sticks_burning = preload("res://assets/objects/hole/HoleSticksBurning.png")
var hole_with_coal = preload("res://assets/objects/hole/HoleWithCoal.png")

onready var COAL_SCENE = preload("res://items/Coal.tscn")

onready var animated_sprite = $AnimatedSprite


func _ready():
	animated_sprite.play("stick-z")


func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Player"):
		if player_is_holding_stick() and hole_status == "empty":
			play_animation("stick-z")
		if hole_status == "with_sticks":
			play_animation("fire-z")
		if hole_status == "with_coal":
			play_animation("coal-z")


func player_is_holding_stick():
	var player_held_item = get_parent().get_node("Player").get("held_item")
	if player_held_item != null:
		return player_held_item.name.to_lower().begins_with("stick")
	return false


func play_animation(animation):
	animated_sprite.play(animation)
	animated_sprite.visible = true


func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Player"):
		animated_sprite.visible = false


func put_sticks():
	get_node(".").set_texture(hole_with_sticks)
	hole_status = "with_sticks"
	animated_sprite.play("fire-z")


func start_fire():
	get_node(".").set_texture(hole_with_sticks_burning)
	hole_status = "with_sticks_burning"
	$Timer.start()
	animated_sprite.visible = false


func _on_Timer_timeout():
	get_node(".").set_texture(hole_with_coal)
	hole_status = "with_coal"
	play_animation("coal-z")


func get_coal():
	get_node(".").set_texture(empty_hole)
	hole_status = "empty"
	animated_sprite.visible = false


func interact(held_item):
	if held_item != null:
		if hole_status == "empty" and held_item.name.to_lower().begins_with("stick"):
			put_sticks()
			return null
	else:
		if hole_status == "with_sticks":
			start_fire()
			return null
		if hole_status == "with_coal":
			get_coal()
			return COAL_SCENE.instance()

	return held_item
