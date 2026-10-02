extends CharacterBody2D

@onready var collision =$CollisionShape2D

var SPEED = 1000.0
const JUMP_VELOCITY = -500.0

var MAX_JUMPS: int = 1
var jumps_done: int = 0
var pudju = false
var vida = Global.vidaPlayer

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		jumps_done = 0
	else:
		if jumps_done == 0:
			jumps_done += 1

	if Input.is_action_just_pressed("ui_accept") and jumps_done < MAX_JUMPS and velocity.y >=0:
		velocity.y = JUMP_VELOCITY
		jumps_done += 1
		
	velocity += get_gravity() * delta
	
	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func morte_player():
	if Global.vidaPlayer == 0:
		Global.vidaPlayer = 3
		get_tree().call_deferred("reload_current_scene")

func puvelocidade():
	var powerUpDuration = 5 
	SPEED = 2000.0
	await get_tree().create_timer(powerUpDuration).timeout
	SPEED = 1000.0

func pudj():
	pudju = true
	MAX_JUMPS = 2
