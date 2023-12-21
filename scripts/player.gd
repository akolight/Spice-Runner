extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_speed = Global.move_speed

var score = 0
var velocity_reset = 4
var anim_speed = 1.0
const anim_multi = 0.01

const SPEED = 1.0
const JUMP_VELOCITY = 5

func _ready():
	velocity.x = 4
	anim_speed = $AnimPlayer.get_speed_scale

func _process(delta):
	#player_position()
	score_count(delta)
	momentum(delta)

func _physics_process(delta):
	$"../Control/debug_spd".set_text(str(velocity.x))
	$"../Control/debug_tim".text = str(Global.elapsed_time_in_ms)
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if velocity.x == 0:
			$CollisionShape3D.set_disabled(true)
			velocity.x = 4
			await get_tree().create_timer(0.5).timeout
			$CollisionShape3D.set_disabled(false)
	
	# Handle upside down jump
	if Input.is_action_just_pressed("jump") and is_on_ceiling():
		velocity.y = -1 * JUMP_VELOCITY
		if velocity.x == 0:
			$CollisionShape3D.set_disabled(true)
			velocity.x = 4
			await get_tree().create_timer(0.5).timeout
			$CollisionShape3D.set_disabled(false)
	
	move_and_slide()

#func _on_obstacle_body_entered(body):
	#velocity.x = 0

func momentum(delta):
	if is_on_floor() and velocity.x > 0:
		velocity.x += 1 * delta
		$AnimPlayer.speed_scale += anim_multi
		anim_speed = $AnimPlayer.get_speed_scale
		
		#print(velocity.x)
	if is_on_ceiling() and velocity.x > 0:
		velocity.x += 1 * delta
		$AnimPlayer.speed_scale += anim_multi
		anim_speed = $AnimPlayer.get_speed_scale

func score_count(delta):
		score += 1 * delta
		$"../Control/ScoreLabel".set_text(str("Score: ",floor(score)))
#func animationController():
	#if is_on_floor():
		#if velocity.x != 0:
			#$AnimPlayer.play("running")
	#else:
		#if velocity.y > 0:
			#$AnimPlayer.play("run jump")

#func player_position():
	#global_position = $"../Path/PathFollow".get_global_position()

#func _on_goal_box_area_body_entered(body):
	#print(str("player pos: ",get_global_position()))
	#print(str("area pos: ", $"../GoalBoxArea/Goalbox".get_global_position()))
	#print("collide")
	#get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_area_3d_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func _on_tipping_point_area_body_entered(body):
	print(str("old grav: ",gravity))
	gravity *= -1
	print(str("new grav: ",gravity))

func _on_goal_area_body_entered(body):
	print("collide")
	get_tree().change_scene_to_file("res://scenes/win.tscn")



func _on_flip_area_body_entered(body):
	var deg2rad = deg_to_rad(180)
	var rotate_tween = get_tree().create_tween()
	rotate_tween.tween_property($".","rotation", Vector3(deg_to_rad(180),deg_to_rad(-90),0),1)
		#rotate(Vector3.RIGHT,deg2rad)
