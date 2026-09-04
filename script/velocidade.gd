extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		body.puvelocidade()
		queue_free()
