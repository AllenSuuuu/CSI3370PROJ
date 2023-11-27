extends CharacterBody2D


var SPEED = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var potionScene = preload("res://Entities/Potion.tscn")
var player
var controller
var chase = false

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = get_node("../../..")
	player = get_node("../../Player/Player")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Run")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		#velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()
	
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		chase = true
		spawnPotion()
	
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
