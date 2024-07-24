extends Control


func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0 , value/5)

func _on_check_button_toggled(toggled_on):
	AudioServer.set_bus_mute(0, toggled_on)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
