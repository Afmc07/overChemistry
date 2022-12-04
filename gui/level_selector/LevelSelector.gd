extends Control


func _on_Level1Button_pressed():
	var node = get_tree().get_root().get_node("Main/AudioStreamPlayer")
	node.stop()
	get_parent().change_scene("res://maps/tutorials/TutorialCarbon.tscn")


func _on_Level2Button_pressed():
	var node = get_tree().get_root().get_node("Main/AudioStreamPlayer")
	node.stop()
	get_parent().change_scene("res://maps/levels/Level01.tscn")

func _on_BackButton_pressed():
	get_parent().change_scene("res://gui/menu/Menu.tscn")
