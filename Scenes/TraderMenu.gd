extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _Input(event : InputEvent):
	if (event.is_action_pressed("Escape")):
		self.hide()
	
	pass
