extends Node

class_name GameController

signal toggle_game_paused(isPaused : bool)

var gamePaused : bool = false:
	get:
		return gamePaused
	set(value):
		gamePaused = value
		get_tree().paused = gamePaused
		emit_signal("toggle_game_paused", gamePaused)

func _input(event : InputEvent):
	if (event.is_action_pressed("Escape")):
		gamePaused = !gamePaused
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func damagePlayer(damage : int):
	Game.playerHP -= damage
		
	#Character blinks when they are damaged
	var player = get_node("Game/Player/Player")
	var tween = get_tree().create_tween()
	tween.tween_property(player, "modulate:a", 0, 0.25)
	tween.tween_property(player, "modulate:a", 1, 0.25)
	tween.tween_property(player, "modulate:a", 0, 0.25)
	tween.tween_property(player, "modulate:a", 1, 0.25)
		
	pass
