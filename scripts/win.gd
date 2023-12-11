extends Control


func _ready():
	var final_format = "Final Time: %.2fs"
	var final_string = final_format % Global.elapsed_time_in_sec
	$FinalScore.text = str(final_string)

func _on_reset_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed():
	get_tree().quit()
