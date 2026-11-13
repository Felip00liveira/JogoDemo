extends StaticBody2D

@export var cena_bala: PackedScene = preload("res://cenas/bala_inimigo.tscn")

@export var alcance: float = 900.0        # distância máxima de visão (px)
@export var intervalo_tiro: float = 1.2   # segundos entre tiros
var vida: int = 100

@onready var olho: RayCast2D = $RayCast2D
@onready var muzzle: Marker2D = $Marker2D

var player: Node2D = null
var espera: float = 0.0


func _physics_process(delta: float) -> void:
	if Global.morto:
		return

	if player == null:
		_achar_player()
		if player == null:
			return

	espera = maxf(espera - delta, 0.0)
	if espera == 0.0 and _ve_o_player():
		_atirar()


func _achar_player() -> void:
	player = get_tree().get_first_node_in_group("Player") as Node2D
	if player == null:
		player = get_tree().current_scene.get_node_or_null("Player") as Node2D


func _ve_o_player() -> bool:
	var ate_o_player := olho.to_local(player.global_position)
	if ate_o_player.length() > alcance:
		return false
	olho.target_position = ate_o_player
	olho.force_raycast_update()
	return olho.is_colliding() and olho.get_collider() == player


func _atirar() -> void:
	espera = intervalo_tiro

	# o cano fica do lado em que o player está
	var lado := signf(player.global_position.x - global_position.x)
	if lado != 0.0:
		muzzle.position.x = absf(muzzle.position.x) * lado

	var bala = cena_bala.instantiate()
	bala.atinge_player = true
	bala.dono = self
	get_tree().root.add_child(bala)
	bala.global_position = muzzle.global_position
	bala.rotation = (player.global_position - muzzle.global_position).angle()


# mesma ideia do saco.gd
func receber_dano(quantidade: int) -> void:
	vida -= quantidade
	if vida <= 0:
		queue_free()
		return
	modulate = Color.RED
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.15)
