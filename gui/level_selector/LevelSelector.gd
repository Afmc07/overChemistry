extends Control


func _on_Level1Button_pressed():
	get_parent().change_scene("res://maps/tutorials/TutorialCarbon.tscn")


func _on_BackButton_pressed():
	get_parent().change_scene("res://gui/menu/Menu.tscn")
