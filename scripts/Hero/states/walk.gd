class_name WalkState
extends State

## Velocidade de caminhada horizontal do Simon (ajustável no Inspetor)
@export var move_speed: float = 120.0

@onready var player: CharacterBody2D = owner as CharacterBody2D


func enter(_previous_state: String, _data := {}) -> void:
	# Tocar a animação de caminhada
	pass


func _physics_update(delta: float) -> void:
	# 1. Se o jogador andar para fora de uma plataforma, entra no estado Fall
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.move_and_slide()
		finished.emit("Fall", {})
		return

	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").play("walk")

	# 2. Leitura da direção de movimento (-1 para esquerda, 1 para direita, 0 para parado)
	var input_direction := Input.get_axis("move_left", "move_right")

	# Se não houver direcional pressionada, volta para o Idle
	if input_direction == 0:
		finished.emit("Idle", {})
		return

	# 3. Aplica a velocidade horizontal e espelha o sprite para a direção correta
	player.velocity.x = input_direction * move_speed

	if player.has_node("Sprite2D"):
		player.get_node("Sprite2D").flip_h = (input_direction < 0)

	# 4. Aplica o movimento na Godot
	player.move_and_slide()

	# --- CHECAGEM DE TRANSIÇÕES ---

	# 5. Atacar enquanto caminha
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	# 6. Pular a partir do movimento
	if Input.is_action_just_pressed("jump"):
		finished.emit("Jump", {})
		return

	# 7. Agachar (parar a caminhada e abaixar)
	if Input.is_action_pressed("move_down"):
		finished.emit("Crouch", {})
		return
