extends Node


onready var current_scene = $Menu
onready var CONFIRMATION_SCENE = preload("res://gui/confirmation/Confirmation.tscn")
onready var RESULT_SCENE = preload("res://gui/result/Result.tscn")


func change_scene(scene: String) -> void:
	var next_scene = load(scene).instance()
	current_scene.queue_free()
	add_child(next_scene)
	current_scene = next_scene

func end_level(timer):
	var result_instance = RESULT_SCENE.instance()
	add_child(result_instance)
	
	var result = 0
	if timer.time < 180:			# Time to get 3 stars
		result = 3
	elif timer.time < 240:			# Time to get 2 stars
		result = 2
	else:
		result = 1
	
	result_instance.set_game_result(result, timer.time_to_string())
	get_tree().paused = true

func return_to_level_selection(result: int):
	change_scene("res://gui/level_selector/LevelSelector.tscn")
	current_scene.set_game_result(result)
	get_tree().paused = false


func _input(event):
	if event.get_action_strength("exit"):
		if current_scene.name != "Menu" and current_scene.name != "LevelSelector":
			var confirmation = CONFIRMATION_SCENE.instance()
			add_child(confirmation)
			get_tree().paused = true
