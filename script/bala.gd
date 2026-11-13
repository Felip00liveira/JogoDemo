#refazer mais tarde essa parte, não gostei muito como ficou
extends Node2D

const SPEED: int = 1500
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


var atinge_player := false   # o inimigo liga isso ao atirar
var dono: Node = null        # quem atirou: a bala ignora esse nó

func _acertar(alvo: Node) -> void:
	if alvo == dono:
		return

	if atinge_player:
		# bala de inimigo: machuca o player e atravessa outros inimigos
		if alvo.has_method("tomar_dano"):
			alvo.tomar_dano(dano)
		elif alvo.has_method("receber_dano"):
			return
	else:
		# bala do player: não machuca o próprio player
		if alvo.has_method("tomar_dano"):
			return
		if alvo.has_method("receber_dano"):
			alvo.receber_dano(dano)
		elif alvo.get_parent() and alvo.get_parent().has_method("receber_dano"):
			alvo.get_parent().receber_dano(dano)

	queue_free()
