extends Sprite


var show_interaction_bubble = false
var status = "empty"

var empty_hole = preload("res://assets/objects/hole/Hole.png")
var hole_with_sticks = preload("res://assets/objects/hole/HoleSticks.png")
var hole_with_sticks_burning = preload("res://assets/objects/hole/HoleSticksBurning.png")
var hole_with_coal = preload("res://assets/objects/hole/HoleWithCoal.png")

onready var COAL_SCENE = preload("res://items/Coal.tscn")


func _on_InteractionArea_area_entered(area):
	var player_held_item = ""
	if area.get_parent().get("held_item") != null:
		player_held_item = area.get_parent().get("held_item").name.to_lower()
	
	if player_held_item == "stick" and status == "empty":
		$AnimatedSprite.play("stick-z")
		$AnimatedSprite.visible = true
	if status == "with_sticks":
		$AnimatedSprite.play("fire-z")
		$AnimatedSprite.visible = true
	if status == "with_coal":
		$AnimatedSprite.play("coal-z")
		$AnimatedSprite.visible = true
	
func _on_InteractionArea_area_exited(area):
	$AnimatedSprite.visible = false

func put_sticks():
	get_node(".").set_texture(hole_with_sticks)
	status = "with_sticks"
	$AnimatedSprite.play("fire-z")
	
func start_fire():
	get_node(".").set_texture(hole_with_sticks_burning)
	status = "with_sticks_burning"
	$Timer.start()
	$AnimatedSprite.visible = false

func _on_Timer_timeout():
	get_node(".").set_texture(hole_with_coal)
	status = "with_coal"
	$AnimatedSprite.play("coal-z")
	$AnimatedSprite.visible = true

func get_coal():
	get_node(".").set_texture(empty_hole)
	status = "empty"
	$AnimatedSprite.visible = false

func interact(held_item):
	if held_item != null:
		if status == "empty" and held_item.name.to_lower() == "stick":
			put_sticks()
			return null
	else:
		if status == "with_sticks":
			start_fire()
			return null
		if status == "with_coal":
			get_coal()
			return COAL_SCENE.instance()
	
	return held_item
