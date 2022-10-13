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

onready var STICK_SCENE = preload("res://maps/objects/Stick.tscn")

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
	
	if Input.is_action_just_pressed("interact"):
		if interacting_with == "tree":
			tree_interaction()
	
	if Input.is_action_just_pressed("pick_drop"):
		if held_item == "":
			pick_item()
		else:
			drop_item()

func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Tree"):
		interacting_with = "tree"
	if area.is_in_group("Stick"):
		print("STIIIIIIIIIIIIIIIIIIICK")
		interacting_item_ref = area
		interacting_with = "stick"


func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Tree"):
		interacting_with = ""
	if area.is_in_group("Stick"):
		interacting_with = ""

func tree_interaction():
	holding_item = true
	held_item = "stick"
	$SpeechBubble.play("stick")
	$SpeechBubble.visible = true

func pick_item():
	if interacting_with == "stick":
		holding_item = true
		held_item = "stick"
		$SpeechBubble.play("stick")
		$SpeechBubble.visible = true
		interacting_item_ref.queue_free()

func drop_item():
	if held_item == "stick":
		var stick = STICK_SCENE.instance()
		stick.position = global_position
		get_parent().add_child(stick)
	holding_item = false
	held_item = ""
	$SpeechBubble.visible = false
