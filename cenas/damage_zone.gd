extends Area2D

func _physics_process(delta: float) -> void:
	for body in get_overlapping_bodies():
		if "Player" in body.name and body.has_method("tomar_dano"):
			body.tomar_dano(25)
