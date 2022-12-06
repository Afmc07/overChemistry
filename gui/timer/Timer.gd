extends Node2D


var time = 0 
func _process(delta):
	time += delta
	$Label.text = time_to_string()

func time_to_string():
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60)/60
	return "%02d:%02d" %[mins, secs]

