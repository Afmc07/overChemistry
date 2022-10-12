extends Node


onready var current_scene = $Menu


func change_scene(scene: String) -> void:
	var next_scene = load(scene).instance()
	current_scene.queue_free()
	add_child(next_scene)
	current_scene = next_scene
