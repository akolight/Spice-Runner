extends Camera3D

var player_pos
var x_offset = 2.0
var y_offset = 2.0
var z_offset = 4.0
var camera_pos = self.position
var follow_speed = 1.0

func _physics_process(delta):
	player_pos = $"../player".get_global_position()
	
	player_pos.x += x_offset
	player_pos.y += y_offset
	player_pos.z += z_offset
	
	camera_pos = camera_pos.lerp(player_pos, delta * follow_speed)
	
	set_position(player_pos)


#func _on_flip_area_body_exited(body):
	#x_offset = 2.0
	#y_offset = -2.0
	#z_offset = 4.0
