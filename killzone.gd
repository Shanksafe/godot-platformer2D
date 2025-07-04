extends Area2D

@onready var timer = $Timer

#handle death
func _on_body_entered(body):
	timer.start()
	print("You died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	
#reload map
func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
