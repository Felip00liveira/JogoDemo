extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.pudj()
		Global.powerup_coletado.emit("double_jump")
		queue_free()
