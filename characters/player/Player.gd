extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO

var interacting_with = ""
var held_item = ""
var holding_item = false

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

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
		
func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Tree"):
		interacting_with = "tree"


func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Tree"):
		interacting_with = ""

func tree_interaction():
	var holding_item = true
	var held_item = "stick"
	$SpeechBubble.play("stick")
	$SpeechBubble.visible = true
	
