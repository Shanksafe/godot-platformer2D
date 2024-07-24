extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var hud = %HUD


func _on_body_entered(body):
	hud.add_point()
	animation_player.play("pickup")
