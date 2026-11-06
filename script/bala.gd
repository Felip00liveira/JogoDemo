extends Node2D

const SPEED: int = 2500
const dano: int = 25

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


# Dispara quando acerta StaticBody2D / CharacterBody2D / TileMap
func _on_area_2d_body_entered(body: Node2D) -> void:
	_acertar(body)


# Dispara quando acerta outra Area2D
func _on_area_2d_area_entered(area: Area2D) -> void:
	_acertar(area)


func _acertar(alvo: Node) -> void:
	if alvo.is_in_group("Player"):
		return

	if alvo.has_method("receber_dano"):
		alvo.receber_dano(dano)
	elif alvo.get_parent() and alvo.get_parent().has_method("receber_dano"):
		# Caso o script esteja no pai da Area2D
		alvo.get_parent().receber_dano(dano)

	queue_free()
