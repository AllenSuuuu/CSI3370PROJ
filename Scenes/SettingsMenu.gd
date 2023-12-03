extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fullscreen_button_toggled(button_pressed):
	if (button_pressed):
		DisplayServer.window_set_mode(3)
	else:
		DisplayServer.window_set_mode(0)
	
	pass # Replace with function body.
