extends Camera2D


onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight
 
func _ready():
	limit_top = topLeft.position.y
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x
	limit_left = topLeft.position.x

