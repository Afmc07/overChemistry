extends Control


func _on_StartButton_pressed():
	get_parent().change_scene("res://gui/level_selector/LevelSelector.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
