extends Control



func set_game_result(result, time):
	$TextureProgress.value = result
	$TimeLabel.text = time

func _on_BackButton_button_up():
	get_parent().return_to_level_selection($TextureProgress.value)
	queue_free()
