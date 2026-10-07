class_name IdleState
extends State

## Referência tipada ao Player (assumindo que o nó raiz do Simon é um CharacterBody2D)
@onready var player: CharacterBody2D = owner as CharacterBody2D


func enter(_previous_state: String, _data := {}) -> void:
	# Zerar a velocidade horizontal imediatamente ao ficar parado
	player.velocity.x = 0
	
	# Executar a animação de Idle


func _physics_update(delta: float) -> void:
	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").play("idle")
	# 1. Aplicar gravidade básica para mantê-lo colado no chão
	#if not player.is_on_floor():
	#	player.velocity += player.get_gravity() * delta
	#	player.move_and_slide()
	#	finished.emit("Fall", {})
	#	return

	#player.move_and_slide()

	# --- CHECAGEM DE TRANSIÇÕES (INPUTS) ---

	# 2. Atacar (Ataque comum ou Sub-arma se estiver segurando Cima)
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	# 3. Pular
	if Input.is_action_just_pressed("jump"):
		finished.emit("Jump", {})
		return

	# 4. Agachar
	if Input.is_action_pressed("move_down"):
		finished.emit("Crouch", {})
		return

	# 5. Caminhar (Movimento horizontal)
	var input_direction := Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		finished.emit("Walk", {})
		return
