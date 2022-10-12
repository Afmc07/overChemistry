extends TextureButton


func _ready():
	if disabled == true:
		$Locked.visible = true
