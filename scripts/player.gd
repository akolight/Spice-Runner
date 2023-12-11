extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var move_speed = 4.0
var move_reset = 4.0

var score = 0

const SPEED = 1.0
const JUMP_VELOCITY = 4.5

func _process(delta):
	score_count()
	momentum(delta)

func _physics_process(delta):
	$"..".progress += move_speed * delta
	$"../../../GoalBoxArea/Goalbox/Control/debug_prg".set_text(str($"..".progress))
	$"../../../GoalBoxArea/Goalbox/Control/debug_spd".set_text(str(move_speed))
	$"../../../GoalBoxArea/Goalbox/Control/debug_tim".text = str(Global.elapsed_time_in_ms)
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if move_speed == 0:
			move_speed = move_reset
	
	move_and_slide()

func _on_obstacle_body_entered(body):
	move_speed = 0

func momentum(delta):
	if is_on_floor() and move_speed > 0:
		move_speed += 1 * delta

func score_count():
		score = $"..".progress * 200
		$"../../../GoalBoxArea/Goalbox/Control/ScoreLabel".set_text(str("Score: ",floor(score)))
#func animationController():
	#if is_on_floor():
		#if velocity.x != 0:
			#$AnimPlayer.play("running")
	#else:
		#if velocity.y > 0:
			#$AnimPlayer.play("run jump")




func _on_goal_box_area_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/win.tscn")


func _on_area_3d_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

