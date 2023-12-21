extends PathFollow3D


func _process(delta):
	Global.pathfollow_current_progress = get_progress()
	$".".progress += Global.move_speed * delta
	#var node_check = get_global_position()
	#print(node_check)
	#print(Global.pathfollow_current_progress)
