extends Node

var vidaPlayer = 100
var vidaSaco = 1000

func morte_player():
	if Global.vidaPlayer <= 0:
		Global.vidaPlayer = 100
		get_tree().call_deferred("reload_current_scene")

func update_vida_player(amount: int):
	vidaPlayer += amount
	print(vidaPlayer)
