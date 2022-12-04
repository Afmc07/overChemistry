extends Node


onready var main = get_tree().get_current_scene()
onready var DEFAULT_PATH = "res://dialogue/dialogues/"

onready var DIALOGUE_BOX_SCENE = preload("res://dialogue/DialogueBox.tscn")


"""
Open the the dialogue from the file res://dialogue/dialogues/<file_path>
"""
func open(file_path):
	var dialogue_box = DIALOGUE_BOX_SCENE.instance()
	main.add_child(dialogue_box)
	dialogue_box.open(DEFAULT_PATH + file_path)
