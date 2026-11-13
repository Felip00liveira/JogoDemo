extends CanvasLayer

@onready var restart_hud: AnimatedSprite2D = $restart_hud

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
@onready var armas: HBoxContainer = $armas

func _ready() -> void:
	restart_hud.visible = false
	Global.player_morreu.connect(_on_player_morreu)
	
	# Borda fica visível; esconde só o ícone de cada slot
	for container: Control in [powerups, armas]:
		for slot in container.get_children():
			var icone: Node = _pegar_icone(slot)
			if icone:
				icone.visible = false
	Global.powerup_coletado.connect(_on_powerup_coletado)

func _on_powerup_coletado(nome: String) -> void:
	for container: Control in [powerups, armas]:
		var slot: Node = container.get_node_or_null(nome + "_hud")
		if slot:
			var icone: Node = _pegar_icone(slot)
			if icone:
				icone.visible = true
			return

# "glock_hud" -> procura o filho "glock_icone_hud"
func _pegar_icone(slot: Node) -> Node:
	var base := String(slot.name).trim_suffix("_hud")
	return slot.get_node_or_null(base + "_icone_hud")
	
func _on_player_morreu() -> void:
	restart_hud.visible = true
	restart_hud.play("default")
