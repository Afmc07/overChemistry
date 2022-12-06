extends Control
onready var musicNode = get_tree().get_root().get_node("Main/music")
onready var clickNode = get_tree().get_root().get_node("Main/click")


func set_game_result(result, time):
	$TextureProgress.value = result
	$TimeLabel.text = time

func _on_BackButton_button_up():
	clickNode.play()
	musicNode.play()
	get_parent().return_to_level_selection($TextureProgress.value)
	queue_free()
