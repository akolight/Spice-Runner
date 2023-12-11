extends Node3D
signal send_score(score)

func _on_player_send_score(score):
	emit_signal("send_score",score)

func _ready():
	pass
