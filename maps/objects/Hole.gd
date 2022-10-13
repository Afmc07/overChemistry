extends Sprite


var show_interaction_bubble = false
var has_stick = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("fire-z")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if show_interaction_bubble:
		$AnimatedSprite.visible = true
	else:
		$AnimatedSprite.visible = false


func _on_InteractionArea_area_entered(area):
	var player_held_item = get_parent().get_node("Player").get("held_item")
	if player_held_item == "stick":
		$AnimatedSprite.play("stick-z")
		show_interaction_bubble = true


func _on_InteractionArea_area_exited(area):
	show_interaction_bubble = false
