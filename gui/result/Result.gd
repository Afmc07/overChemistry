extends Control



func set_game_result(result):
	$TextureProgress.value = result

func _on_BackButton_button_up():
	get_parent().return_to_level_selection($TextureProgress.value)
	queue_free()
