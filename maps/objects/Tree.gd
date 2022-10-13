extends Sprite


var show_interaction_bubble = false


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
	show_interaction_bubble = true

func _on_InteractionArea_area_exited(area):
	show_interaction_bubble = false
