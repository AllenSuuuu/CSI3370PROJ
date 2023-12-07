extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	get_tree().paused = false
	
	pass # Replace with function body.
