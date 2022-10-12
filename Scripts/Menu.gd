extends Control


func _on_Button_pressed():
	get_parent().select_level()


func _on_Button2_pressed():
	get_tree().quit()
