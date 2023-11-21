extends CharacterBody2D


var controller

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = get_node("../../..")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_damage_box_body_entered(body):
	if body.name == "Player":
		controller.damagePlayer(1)

	pass # Replace with function body.
