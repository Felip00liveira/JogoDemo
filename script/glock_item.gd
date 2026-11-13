extends Area2D

@export var cena_arma: PackedScene = preload("res://cenas/glock.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("equipar_arma"):
		body.equipar_arma(cena_arma)
		queue_free()
