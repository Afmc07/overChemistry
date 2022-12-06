extends Control

onready var musicNode = get_tree().get_root().get_node("Main/music")
onready var clickNode = get_tree().get_root().get_node("Main/click")


func _ready():
	if not DialogueUtils.level_selector_dialogue_shown:
		DialogueUtils.open("LevelSelector.json")
		DialogueUtils.level_selector_dialogue_shown = true


func set_game_result(result):
	$TextureProgress.value = result


func _on_Level1Button_pressed():
	clickNode.play()
	start_level("res://maps/tutorials/TutorialCarbon.tscn")


func _on_Level2Button_pressed():
	clickNode.play()
	start_level("res://maps/tutorials/TutorialIronCopper.tscn")

func _on_Level3Button_pressed():
	clickNode.play()
	start_level("res://maps/levels/Level01.tscn")

func start_level(scene):
	musicNode.stop()
	get_parent().change_scene(scene)

func _on_BackButton_pressed():
	clickNode.play()
	get_parent().change_scene("res://gui/menu/Menu.tscn")

