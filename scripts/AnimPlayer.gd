extends AnimationPlayer

@onready var player = $".."

func _physics_process(delta):
	
	if player.velocity.y > 0:
		play("run jump")
	
	#if player.velocity.y < 0:
		#play("fall to land")
	
	if player.velocity.y == 0:
		play("running")
