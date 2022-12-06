extends Control

onready var clickNode = get_tree().get_root().get_node("Main/click")


func _on_StartButton_pressed():
	clickNode.play()
	get_parent().change_scene("res://gui/level_selector/LevelSelector.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
