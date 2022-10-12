extends Control


func _on_YesButton_pressed():
	get_tree().paused = false
	get_parent().change_scene("res://gui/level_selector/LevelSelector.tscn")
	queue_free()


func _on_NoButton_pressed():
	get_tree().paused = false
	queue_free()
