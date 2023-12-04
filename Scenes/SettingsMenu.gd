extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MarginContainer/VBoxContainer/FullscreenButton").button_pressed = Game.fullscreen
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fullscreen_button_toggled(button_pressed):
	if (button_pressed):
		DisplayServer.window_set_mode(3)
		Game.fullscreen = true
	else:
		DisplayServer.window_set_mode(0)
		Game.fullscreen = false
	
	pass # Replace with function body.


func _input(event : InputEvent):
	if (event.is_action_pressed("Escape")):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
	pass
