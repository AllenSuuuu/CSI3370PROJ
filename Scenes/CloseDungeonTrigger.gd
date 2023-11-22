extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


@onready var tilemap = get_node("../GameController/Game/TileMap")

func _on_body_entered(body):
	if body.name == "Player":
		for i in 7:
			tilemap.set_cell(0, Vector2(120 + i, 19), 0, Vector2(1, 1))
			tilemap.set_cell(0, Vector2(156 + i, 19), 0, Vector2(1, 1))
	
	
	
	pass # Replace with function body.
