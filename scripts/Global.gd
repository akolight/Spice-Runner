extends Control

var total_score = 0
var is_counting = false
var start_time
var elapsed_time_in_sec
var elapsed_time_in_ms

func _ready():
	pass

func _process(delta):
	if is_counting:
		elapsed_time_in_ms = floor((Time.get_ticks_msec() - start_time))
		elapsed_time_in_sec = (Time.get_ticks_msec() - start_time) / 1000
		print(elapsed_time_in_sec)

func set_timer(is_start):
	if is_start:
		is_counting = true
		start_time = Time.get_ticks_msec()
		print(1)
	else:
		is_counting = false


func _on_platform_test_send_score(score):
	total_score = score
	$ScoreLabel.set_text(str("Score: ",floor(total_score)))
