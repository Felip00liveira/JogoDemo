extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.vidaPlayer -= 1
		body.morte_player()
		print("Dano")
