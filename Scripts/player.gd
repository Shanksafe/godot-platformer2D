extends CharacterBody2D

#variables
const SPEED = 140.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 1000
const FALL_GRAVITY = 750

#wall jumping and sliding
const JUMP_POWER = -250.0
const WALL_JUMP_PUSHBACK = 100
const WALL_SLIDE_GRAVITY = 50
var IS_WALL_SLIDING = false

#better jump

# vector2 usually describes x and y data
func get_gravity(velocity: Vector2): 
	if velocity.y < 0:
		return GRAVITY
	else:
		return FALL_GRAVITY

#references
@onready var animated_sprite = $AnimatedSprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			IS_WALL_SLIDING = true
		else:
			IS_WALL_SLIDING = false
	else:
		IS_WALL_SLIDING = false
	
	if IS_WALL_SLIDING:
		velocity.y += (WALL_SLIDE_GRAVITY * delta)
		velocity.y = min(velocity.y, WALL_SLIDE_GRAVITY)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity(velocity) * delta
	
	#handle more realistic jump
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4 

	#handle jump and wall jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_POWER
		if is_on_wall() and Input.is_action_pressed("move_left"):
			velocity.y = JUMP_POWER 
			velocity.x = WALL_JUMP_PUSHBACK
		if is_on_wall() and Input.is_action_pressed("move_right"):
			velocity.y = JUMP_POWER 
			velocity.x = -WALL_JUMP_PUSHBACK

	#gets input direction -1 0 1 
	var direction = Input.get_axis("move_left", "move_right")
	
	#flip sprite 
	if direction > 0:
		animated_sprite.flip_h = false 
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#animations
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	if not is_on_floor() and !is_on_wall():
		animated_sprite.play("jump")
	
	
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	wall_slide(delta)
