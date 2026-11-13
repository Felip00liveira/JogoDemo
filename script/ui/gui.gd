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
	else:
		$player_vida.frame = 4

@onready var powerups: HBoxContainer = $powerup

func _ready() -> void:
	# Borda fica visível; esconde só o ícone de cada slot
	for slot in powerups.get_children():
		var icone := _pegar_icone(slot)
		if icone:
			icone.visible = false
	Global.powerup_coletado.connect(_on_powerup_coletado)

func _on_powerup_coletado(nome: String) -> void:
	var slot := powerups.get_node_or_null(nome + "_hud")
	if slot:
		var icone := _pegar_icone(slot)
		if icone:
			icone.visible = true

# "double_jump_hud" -> procura o filho "double_jump_icone_hud"
func _pegar_icone(slot: Node) -> Node:
	var base := String(slot.name).trim_suffix("_hud")
	return slot.get_node_or_null(base + "_icone_hud")
