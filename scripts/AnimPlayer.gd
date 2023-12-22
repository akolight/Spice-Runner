extends AnimationPlayer

@onready var player = $".."

var slide_state = false
var idle_state = false

func _physics_process(delta):
	
	if player.velocity.y > 0 and Input.is_action_just_pressed("jump") and Global.jump_count > 0:
		$".".speed_scale = 1
		play("run jump")
		
	if player.velocity.x == 0:
		idle_state = true
	#if player.velocity.y < 0:
		#play("fall to land")
	
	if player.velocity.y == 0 and Input.is_action_just_pressed("slide"):
		slide_state = true
	
	if idle_state == true:
		play("idle_breathing")
		
	if player.velocity.y == 0 and slide_state == true and player.velocity.x > 0:
		Global.jump_count = 0
		$".".speed_scale = 1
		play("slide")
	if player.velocity.y == 0 and slide_state == false and player.velocity.x > 0:
		play("running")

func _on_animation_finished(slide):
	slide_state = false
	Global.jump_count = 1

func _on_anim_player_2_animation_finished(anim_name):
	idle_state = false
