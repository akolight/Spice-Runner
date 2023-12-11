extends Control



func _on_begin_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	Global.set_timer(true)


func _on_options_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
