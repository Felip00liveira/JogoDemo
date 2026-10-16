extends CanvasLayer

func _process(delta):
	$vida_valor.text = var_to_str(Global.vidaPlayer)
	vidaimagem()

func vidaimagem():
	if Global.vidaPlayer > 75:
		$player_vida.frame = 0
	elif Global.vidaPlayer > 50:
		$player_vida.frame = 1
	elif Global.vidaPlayer > 25:
		$player_vida.frame = 2
	elif Global.vidaPlayer > 0:
		$player_vida.frame = 3
