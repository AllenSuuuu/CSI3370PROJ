extends CharacterBody2D

var hp = 5
var isAlive : bool = true
var SPEED = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var potionScene = preload("res://Entities/Potion.tscn")
var player
var controller
var jumpTimer : Timer
var potTimer : Timer
const range : int = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	jumpTimer = $JumpTimer
	potTimer = $PotionTimer
	controller = get_node("../../..")
	player = get_node("../../Player/Player")
	
	pass # Replace with function body.


var direction = Vector2(-1, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity
	velocity.y += gravity * delta
	if get_node("AnimatedSprite2D").animation != "Death":
		get_node("AnimatedSprite2D").play("Run")
	player = get_node("../../Player/Player")
	
	
	if (is_on_wall()):
		direction.x *= -1
	
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
	velocity.x = direction.x * SPEED
	
	if (velocity.x == 0):
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()
	
	pass


func spawnPotion():
	call_deferred("_spawnPotion")

func _spawnPotion():
	var potInstance = potionScene.instantiate()
	potInstance.position = position
	potInstance.position.y -= 50
	get_parent().add_child(potInstance)
	
	pass


func _on_jump_timer_timeout():
	jump()
	
	jumpTimer.wait_time = randf_range(0.5, 1.5)
	
	pass # Replace with function body.


func jump():
	if (isAlive):
		if (is_on_floor()):
			velocity.y += -450
	
	pass


func _on_potion_timer_timeout():
	if (isAlive):
		var playerPos = player.position
		var pos = self.position
		
		var displacementX = playerPos.x - pos.x
		var displacementY = playerPos.y - pos.y
		
		if (displacementX >= -range && displacementX <= range):
			if (displacementY >= -range && displacementY <= range):
				spawnPotion()
		
		potTimer.wait_time = randf_range(0.5, 1.5)
	
	pass # Replace with function body.


func death():
	Game.Gold += 15
	Utils.saveGame()
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	get_node("../../UI/WinScreen").show()
	get_tree().paused = true
	self.queue_free()
	
	pass


func takeDamage():
	hp -= 2
	
	if (hp <= 0):
		death()
	
	pass
