extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var isAttacking : bool = false
var canDoubleJump : bool = true
var hasArmor : bool = false
var armor : String = "None"

var jumpAnim = "Jump"
var runAnim = "Run"
var idleAnim = "Idle"
var attackAnim = "Attack"
var attackAnim2 = "Attack2"

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
	var swordHit = get_node("AnimatedSprite2D/SwordHit")
	
	if (get_node("AnimationPlayer").get_assigned_animation() != "Attack"):
		isAttacking = false
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
		swordHit.scale.x = -direction
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		swordHit.scale.x = -direction
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			if (Input.is_action_pressed("Attack")):
				attack()
			
			if (!isAttacking):
				anim.play(runAnim)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if (Input.is_action_pressed("Attack")):
			attack()
		
		if (!isAttacking):
			anim.play(idleAnim)
	
	if (get_node("AnimationPlayer").get_assigned_animation() != "Attack"):
		get_node("AnimatedSprite2D/SwordHit/CollisionShape2D").set_disabled(true)
	
	if velocity.y > 0:
		if (Input.is_action_pressed("Attack")):
			attack()
		
		if (!isAttacking):
			anim.play("Fall")
	move_and_slide()
	
	
	if Game.playerHP <= 0:
		var checkpoint = Game.currentCheckpoint
		
		if (checkpoint == null):
			queue_free()
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
		else:
			goToCheckpoint()
		
		Game.playerHP = 10
		Game.Gold = 0
		Game.hasJumpBoots = false
		
	
	pass


func attack():
	isAttacking = true
	anim.play(attackAnim)
	await $AnimationPlayer.animation_finished
	isAttacking = false
	
	pass


func goToCheckpoint():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Game.currentCheckpoint.position, 0)
	pass


func _on_sword_hit_area_entered(area):
	
	pass # Replace with function body.


func _on_sword_hit_body_entered(body):
	var zombie = "Frog"
	var boss = "Boss"
	if (boss in body.name || zombie in body.name):
		get_node("../../Mobs/" + body.name).takeDamage()
	
	pass # Replace with function body.
