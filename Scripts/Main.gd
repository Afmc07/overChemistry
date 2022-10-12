extends Node


onready var current_scene = $Menu


func select_level() -> void:
	var next_scene = load("res://Node2D.tscn").instance()
	current_scene.queue_free()
	add_child(next_scene)
	current_scene = next_scene
