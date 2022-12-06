extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO

var item_in_range = null
var map_object_in_range = null
var held_item = null

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var interaction_area = $Position2D/InteractionArea
onready var bubble = $ItemBubble
onready var audioFx = $AudioStreamPlayer

func _on_InteractionArea_area_entered(area):
	if area.is_in_group("Item"):
		item_in_range = area

	if area.get_parent().is_in_group("MapObject"):
		map_object_in_range = area.get_parent()
	
	if area.get_parent().is_in_group("River"):
		map_object_in_range = area.get_parent()



func _on_InteractionArea_area_exited(area):
	if area.is_in_group("Item"):
		if not has_overlapping_item():
			item_in_range = null

	if area.get_parent().is_in_group("MapObject"):
		if not has_overlapping_map_object():
			map_object_in_range = null
	if area.get_parent().is_in_group("River"):
		if not has_overlapping_map_object():
			map_object_in_range = null


func has_overlapping_item():
	var overlapping_areas = interaction_area.get_overlapping_areas()
	for area in overlapping_areas:
		if area.is_in_group("Item"):
			return true
	return false


func has_overlapping_map_object():
	var overlapping_areas = interaction_area.get_overlapping_areas()
	for area in overlapping_areas:
		if area.get_parent().is_in_group("MapObject"):
			return true
	return false


func _physics_process(delta):
	update_bubble()
	handle_velocity(delta)
	handle_item_actions()
	handle_map_interactions()


func update_bubble():
	if should_show_bubble():
		bubble.visible = true
		bubble.play(held_item_name())
	else:
		bubble.visible = false


func should_show_bubble():
	return held_item != null

func held_item_name():
	return held_item.name.to_lower().rstrip("0123456789")


func handle_velocity(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	if map_object_in_range != null:
		if map_object_in_range.is_in_group("River"):
			input_vector.y -= 1.5

	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x < 0:
			sprite.flip_h = true
		if input_vector.x == 0 and input_vector.y == -1.5:
			animation_player.play("Idle")
		else: 
			animation_player.play("Walking")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_player.play("Idle")
		velocity = velocity.move_toward(input_vector, FRICTION * delta)

	velocity = move_and_slide(velocity)


func handle_item_actions():
	if Input.is_action_just_pressed("pick_drop"):
		if can_pick_item():
			pick_item()
		else:
			drop_item()


func can_pick_item():
	return held_item == null and has_overlapping_item()


func pick_item():
	audioFx.play()
	held_item = item_in_range.duplicate()
	item_in_range.queue_free()


func drop_item():
	if held_item != null:
		audioFx.play()
		held_item.position = global_position
		get_parent().add_child(held_item)
		held_item = null


func handle_map_interactions():
	if Input.is_action_just_pressed("interact") and map_object_in_range != null:
		held_item = map_object_in_range.interact(held_item)
