extends Node

signal powerup_coletado(nome: String)
signal player_morreu

var vidaPlayer = 100
var vidaSaco = 1000
var morto = false

func morte_player():
	if vidaPlayer <= 0 and not morto:
		morto = true
		player_morreu.emit()

func update_vida_player(amount: int):
	if morto:
		return
	vidaPlayer += amount
	print(vidaPlayer)

func reiniciar():
	vidaPlayer = 100
	morto = false
	get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
	if morto and event.is_action_pressed("restart"):
		reiniciar()
