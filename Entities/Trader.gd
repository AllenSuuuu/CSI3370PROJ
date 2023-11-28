extends CharacterBody2D


var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player/Player")
	
	pass # Replace with function body.


var displacement
const RANGE = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	displacement = Vector2(player.position - self.position)
	
	if (displacement.x >= -RANGE && displacement.x <= RANGE):
		if (displacement.y >= -RANGE && displacement.y <= RANGE):
			if (Input.is_action_pressed("E")):
				buyArmor("Armor1")
	
	pass


var armor1Price = 15
var armor2Price = 30

func buyArmor(armor : String):
	if (armor == "Armor1"):
		if (!player.hasArmor):
			player.hasArmor = true
			player.armor = armor
			player.jumpAnim = "JumpArmor1"
			player.runAnim = "RunArmor1"
			player.idleAnim = "IdleArmor1"
		
	if (armor == "Armor2"):
		if (player.armor != armor):
			player.hasArmor = true
			player.armor = armor
			player.jumpAnim = "JumpArmor2"
			player.runAnim = "RunArmor2"
			player.idleAnim = "IdleArmor2"
	
	pass
