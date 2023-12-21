extends Camera3D

var player_pos
const x_offset = 2.0
const y_offset = 2.0
const z_offset = 4.0
var camera_pos

func _physics_process(delta):
	player_pos = $"../player".get_global_position()
	
	player_pos.x += x_offset
	player_pos.y += y_offset
	player_pos.z += z_offset
	
	camera_pos = player_pos
	
	set_position(player_pos)
