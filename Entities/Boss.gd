extends CharacterBody2D

var hp = 10
var SPEED = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var potionScene = preload("res://Entities/Potion.tscn")
var player
var controller
var chase = false
var jumpTimer : Timer
var potTimer : Timer

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


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		chase = true
		#spawnPotion()
	
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		chase = false
	
	pass # Replace with function body.


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
	if (is_on_floor()):
		velocity.y += -350
	
	pass


func _on_potion_timer_timeout():
	spawnPotion()
	
	potTimer.wait_time = randf_range(0.5, 1.5)
	
	pass # Replace with function body.
