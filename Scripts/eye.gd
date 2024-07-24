extends Node2D

#enemy variables
const speed = 60
var direction = 1 

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

#handle collisons against walls 
func _process(delta):
	position.x += direction * speed * delta
	if ray_cast_left.is_colliding():
		direction = 1 
		animated_sprite.flip_h = false
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
