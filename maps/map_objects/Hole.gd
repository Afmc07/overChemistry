extends Sprite


var show_interaction_bubble = false
var status = "empty"

var empty_hole = preload("res://assets/objects/hole/Hole.png")
var hole_with_sticks = preload("res://assets/objects/hole/HoleSticks.png")
var hole_with_sticks_burning = preload("res://assets/objects/hole/HoleSticksBurning.png")
var hole_with_coal = preload("res://assets/objects/hole/HoleWithCoal.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("stick-z")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show_interaction_bubble:
		$AnimatedSprite.visible = true
	else:
		$AnimatedSprite.visible = false

func _on_InteractionArea_area_entered(area):
	var player_held_item = get_parent().get_node("Player").get("held_item")
	if player_held_item == "stick" and status == "empty":
		$AnimatedSprite.play("stick-z")
		show_interaction_bubble = true
	if status == "with_sticks":
		$AnimatedSprite.play("fire-z")
		show_interaction_bubble = true
	if status == "with_coal":
		$AnimatedSprite.play("coal-z")
		show_interaction_bubble = true		
	
func _on_InteractionArea_area_exited(area):
	show_interaction_bubble = false

func put_sticks():
	get_node(".").set_texture(hole_with_sticks)
	status = "with_sticks"
	$AnimatedSprite.play("fire-z")
	
func start_fire():
	get_node(".").set_texture(hole_with_sticks_burning)
	status = "with_sticks_burning"
	$Timer.start()
	show_interaction_bubble = false

func _on_Timer_timeout():
	get_node(".").set_texture(hole_with_coal)
	status = "with_coal"
	$AnimatedSprite.play("coal-z")
	show_interaction_bubble = true

func get_coal():
	get_node(".").set_texture(empty_hole)
	status = "empty"
	show_interaction_bubble = false
