extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		Global.update_vida_player(-25)
		Global.morte_player()
		print("Dano")
