extends Control


onready var text_label = $Panel/Columns/TextContainer/Text

var conversation = []
var current_index = 0


func open(dialogue_file_path):
	conversation = read_file(dialogue_file_path)
	current_index = 0
	if conversation.size() > 0:
		show()
		update()

func read_file(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		return parse_json(file.get_as_text())
	else:
		return []

func next():
	if current_index < conversation.size() - 1:
		current_index += 1
		update()

func previous():
	if current_index > 0:
		current_index -= 1
		update()

func update():
	text_label.text = conversation[current_index].text


func _on_ButtonNext_button_up():
	next()


func _on_ButtonPrev_button_up():
	previous()


func _on_ButtonFinish_button_up():
	queue_free()
#	hide()
