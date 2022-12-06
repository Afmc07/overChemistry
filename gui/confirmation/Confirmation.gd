extends Control

onready var musicNode = get_tree().get_root().get_node("Main/music")
onready var clickNode = get_tree().get_root().get_node("Main/click")

func _on_YesButton_pressed():
	clickNode.play()
	get_tree().paused = false
	musicNode.play()
	get_parent().change_scene("res://gui/level_selector/LevelSelector.tscn")
	queue_free()


func _on_NoButton_pressed():
	clickNode.play()
	get_tree().paused = false
	queue_free()
