extends Control


@export var controller : GameController

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	controller.connect("toggle_game_paused", _on_game_controller_toggle_game_paused)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_controller_toggle_game_paused(isPaused : bool):
	if (isPaused):
		show()
	else:
		hide()


func _on_button_pressed():
	controller.gamePaused = false
	
	pass # Replace with function body.


func _on_return_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	controller.gamePaused = false
	
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	
	pass # Replace with function body.
