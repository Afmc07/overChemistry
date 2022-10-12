extends Node


onready var current_scene = $Menu
onready var CONFIRMATION_SCENE = preload("res://gui/confirmation/Confirmation.tscn")


func change_scene(scene: String) -> void:
	var next_scene = load(scene).instance()
	current_scene.queue_free()
	add_child(next_scene)
	current_scene = next_scene


func _input(event):
	if Input.get_action_strength("exit"):
		if current_scene.name != "Menu" and current_scene.name != "LevelSelector":
			var confirmation = CONFIRMATION_SCENE.instance()
			add_child(confirmation)
			get_tree().paused = true
