extends CanvasLayer

var score = 0

@onready var score_label = $Score_Label

func add_point():
	score += 1 
	score_label.text = str(score)
	if score == 5:
		get_tree().change_scene_to_file("res://Scenes/victory.tscn")
