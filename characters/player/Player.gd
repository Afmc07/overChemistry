extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO

var interacting_with = null
var held_item = null

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
	
	update_bubble()
	
	if Input.is_action_just_pressed("pick_drop"):
		if held_item == null:
			if interacting_with != null:
				pick_item()
		else:
			drop_item()

	if Input.is_action_just_pressed("interact") and interacting_with != null:
		if interacting_with.is_in_group("MapObject"):
			held_item = interacting_with.interact(held_item)

func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Item"):
		interacting_with = area
	elif area.get_parent().is_in_group("MapObject"):
		interacting_with = area.get_parent()

func _on_InteractionArea_area_exited(area):
	interacting_with = null

func update_bubble():
	$SpeechBubble.visible = held_item != null
	if held_item != null:
		$SpeechBubble.play(held_item.name.to_lower())

func pick_item():
	if interacting_with.is_in_group("Item"):
		held_item = interacting_with.duplicate()
		interacting_with.queue_free()

func drop_item():
	held_item.position = global_position
	get_parent().add_child(held_item)
	held_item = null
