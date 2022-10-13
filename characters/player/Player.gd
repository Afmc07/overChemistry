extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO

var interacting_item_ref = null
var interacting_with = ""
var held_item = ""
var holding_item = false

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

onready var STICK_SCENE = preload("res://items/Stick.tscn")
onready var COAL_SCENE = preload("res://items/Coal.tscn")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x < 0:
			sprite.flip_h = true
		animationPlayer.play("Walking")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else: 
		animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
		
	if Input.is_action_just_pressed("pick_drop"):
		if !holding_item:
			pick_item()
		else:
			drop_item()

	if Input.is_action_just_pressed("interact"):
		if interacting_with == "tree":
			tree_interaction()
			
		if interacting_with == "hole":
			hole_interaction()

func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Tree"):
		interacting_with = "tree"
	
	if area.is_in_group("Hole"):
		interacting_with = "hole"

	if area.is_in_group("Stick"):
		interacting_item_ref = area
		interacting_with = "stick"
	
	if area.is_in_group("Coal"):
		interacting_item_ref = area
		interacting_with = "coal"

func _on_InteractionArea_area_exited(area):
	interacting_with = ""

func pick_item():
	if interacting_with == "stick":
		held_item = "stick"
		$SpeechBubble.play("stick")
		holding_item = true
		$SpeechBubble.visible = true
		interacting_item_ref.queue_free()
	
	if interacting_with == "coal":
		held_item = "coal"
		$SpeechBubble.play("coal")
		holding_item = true
		$SpeechBubble.visible = true
		interacting_item_ref.queue_free()

func drop_item():
	if held_item == "stick":
		var stick = STICK_SCENE.instance()
		stick.position = global_position
		get_parent().add_child(stick)
	
	if held_item == "coal":
		var coal = COAL_SCENE.instance()
		coal.position = global_position
		get_parent().add_child(coal)
	
	holding_item = false
	held_item = ""
	$SpeechBubble.visible = false

func tree_interaction():
	if !holding_item:
		holding_item = true
		held_item = "stick"
		$SpeechBubble.play("stick")
		$SpeechBubble.visible = true

func hole_interaction():
	var hole = get_parent().get_node("Hole")
	var hole_status = hole.get("status")
	
	if hole_status == "empty" and held_item == "stick":
		holding_item = false
		held_item = ""
		$SpeechBubble.visible = false
		hole.put_sticks()
	
	if hole_status == "with_sticks" and !holding_item:
		hole.start_fire()
	
	if hole_status == "with_coal" and !holding_item:
		holding_item = true
		held_item = "coal"
		$SpeechBubble.play("coal")
		$SpeechBubble.visible = true
		hole.get_coal()
