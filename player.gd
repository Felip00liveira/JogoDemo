extends CharacterBody2D

@onready var collision =$CollisionShape2D

var SPEED = 1000.0
const JUMP_VELOCITY = -500.0

var MAX_JUMPS: int = 1
var jumps_done: int = 0
var pudju = false
var arma_atual: Node2D = null

func _ready() -> void:
	Global.player_morreu.connect(_on_morreu)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		jumps_done = 0
	else:
		if jumps_done == 0:
			jumps_done += 1

	if not Global.morto and Input.is_action_just_pressed("ui_accept") and jumps_done < MAX_JUMPS and velocity.y >= 0:
		velocity.y = JUMP_VELOCITY
		jumps_done += 1

	velocity += get_gravity() * delta

	var direction := 0.0 if Global.morto else Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_morreu() -> void:
	# futuramente: tocar a animação de morte aqui
	if arma_atual:
		arma_atual.visible = false

func puvelocidade():
	var powerUpDuration = 5
	SPEED = 2000.0
	await get_tree().create_timer(powerUpDuration).timeout
	SPEED = 1000.0

func pudj():
	pudju = true
	MAX_JUMPS = 2

func equipar_arma(cena_arma: PackedScene) -> void:
	if arma_atual:
		arma_atual.queue_free()
	arma_atual = cena_arma.instantiate()
	add_child(arma_atual)
	arma_atual.position = Vector2(6, 8)
	arma_atual.show_behind_parent = true   # arma atrás do player
