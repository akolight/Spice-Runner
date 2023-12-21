extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_speed = Global.move_speed

var score = 0
var velocity_reset = 4

const SPEED = 1.0
const JUMP_VELOCITY = 4

func _ready():
	velocity.x = 4

func _process(delta):
	#player_position()
	score_count()
	momentum(delta)

func _physics_process(delta):
	$"../GoalBoxArea/Goalbox/Control/debug_spd".set_text(str(move_speed))
	$"../GoalBoxArea/Goalbox/Control/debug_tim".text = str(Global.elapsed_time_in_ms)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if velocity.x == 0:
			velocity.x = velocity_reset
	
	move_and_slide()

func _on_obstacle_body_entered(body):
	velocity.x = 0

func momentum(delta):
	if is_on_floor() and velocity.x > 0:
		velocity.x += 1 * delta
		$AnimPlayer.speed_scale += 0.01
		print(velocity.x)

func score_count():
		score = $"../Path/PathFollow".progress * 200
		$"../GoalBoxArea/Goalbox/Control/ScoreLabel".set_text(str("Score: ",floor(score)))
#func animationController():
	#if is_on_floor():
		#if velocity.x != 0:
			#$AnimPlayer.play("running")
	#else:
		#if velocity.y > 0:
			#$AnimPlayer.play("run jump")

#func player_position():
	#global_position = $"../Path/PathFollow".get_global_position()

func _on_goal_box_area_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/win.tscn")


func _on_area_3d_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

