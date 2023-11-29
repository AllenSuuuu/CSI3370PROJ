extends Area2D


var isInArea = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_pressed("Attack") && isInArea):
		revealArea()
	pass


func _Input(event : InputEvent):
	
	
	pass


@onready var tilemap = get_node("../../TileMap")

func _on_body_entered(body):
	if (body.name == "Player"):
		isInArea = true
		
	pass # Replace with function body.


func revealArea():
	for i in 3:
		tilemap.set_cell(0, Vector2(162, 38 + i), 0, Vector2(21, 18))
		tilemap.set_cell(0, Vector2(163 + i, 37), 0, Vector2(19, 18))
		tilemap.set_cell(0, Vector2(163 + i, 41), 0, Vector2(19, 18))
		tilemap.set_cell(0, Vector2(166, 38 + i), 0, Vector2(19, 18))
		for j in 3:
			tilemap.set_cell(0, Vector2(163 + j, 38 + i), 0, Vector2(21, 18))
	
	pass


func _on_body_exited(body):
	if (body.name == "Player"):
		isInArea = false
		
	pass # Replace with function body.
