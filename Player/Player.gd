extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var canDoubleJump : bool = true
var hasArmor : bool = false
var armor : String = "None"

var jumpAnim = "Jump"
var runAnim = "Run"
var idleAnim = "Idle"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta 
	# Handle Jump.
	if (is_on_floor()):
		canDoubleJump = true
		if (Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("W") || Input.is_action_just_pressed("Space")):
			velocity.y = JUMP_VELOCITY
			anim.play(jumpAnim)
	else:
		if (canDoubleJump && Game.hasJumpBoots):
			if (Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("W") || Input.is_action_just_pressed("Space")):
				velocity.y = JUMP_VELOCITY
				anim.play(jumpAnim)
				canDoubleJump = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	direction += Input.get_axis("A", "D")

	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play(runAnim)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			#if (Input.is_action_pressed("Attack")):
			#	anim.play("Attack")
			#else:
				anim.play(idleAnim)
	if velocity.y > 0:
		anim.play("Fall")
	move_and_slide()
	
	
	if Game.playerHP <= 0:
		var checkpoint = Game.currentCheckpoint
		
		if (checkpoint == null):
			queue_free()
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
		else:
			goToCheckpoint(checkpoint)
		
		Game.playerHP = 10
		Game.Gold = 0
		Game.hasJumpBoots = false
		
	
	pass

func goToCheckpoint(checkpoint : Area2D):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Game.currentCheckpoint.position, 0)
	pass
