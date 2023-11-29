extends CharacterBody2D

class_name Trader

var player
var controller

signal toggle_buy_menu(menuOpen : bool)

var menuOpen : bool = false:
	get:
		return menuOpen
	set(value):
		menuOpen = value
		get_tree().paused = menuOpen
		emit_signal("toggle_buy_menu", menuOpen)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player/Player")
	controller = get_node("../../..")
	
	pass # Replace with function body.


var displacement
const RANGE = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	displacement = Vector2(player.position - self.position)
	
	if (displacement.x >= -RANGE && displacement.x <= RANGE):
		if (displacement.y >= -RANGE && displacement.y <= RANGE):
			if (Input.is_action_pressed("E")):
				openBuyMenu()
	
	pass


const ARMOR1PRICE = 15
const ARMOR2PRICE = 30

func buyArmor(armor : String):
	if (armor == "Armor1"):
		if (!player.hasArmor):
			if (Game.Gold >= ARMOR1PRICE):
				print("Gold reduced")
				Game.Gold -= ARMOR1PRICE
				Game.playerHP += 5
				player.hasArmor = true
				player.armor = armor
				player.jumpAnim = "JumpArmor1"
				player.runAnim = "RunArmor1"
				player.idleAnim = "IdleArmor1"
		
	if (armor == "Armor2"):
		if (player.armor != armor):
			if (Game.Gold >= ARMOR2PRICE):
				Game.Gold -= ARMOR2PRICE
				Game.playerHP += 10
				player.hasArmor = true
				player.armor = armor
				player.jumpAnim = "JumpArmor2"
				player.runAnim = "RunArmor2"
				player.idleAnim = "IdleArmor2"
	
	pass


func openBuyMenu():
	get_node("../../UI/TraderMenu").show()
	get_tree().paused = true
	menuOpen = true
	pass


func _on_buy_armor_1_button_pressed():
	buyArmor("Armor1")
	
	pass # Replace with function body.


func _on_buy_armor_2_button_pressed():
	buyArmor("Armor1")
	
	pass # Replace with function body.
