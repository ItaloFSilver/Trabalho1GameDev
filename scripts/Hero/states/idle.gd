class_name IdleState
extends State

## Referência tipada ao Player (assumindo que o nó raiz do Simon é um CharacterBody2D)
@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	# Zerar a velocidade horizontal imediatamente ao ficar parado
	player.velocity.x = 0


func _physics_update(delta: float) -> void:
	
	player.anim.play("idle")
	# 1. Aplicar gravidade básica para mantê-lo colado no chão
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.move_and_slide()
		finished.emit("Fall", {})
		return

	player.move_and_slide()

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
		
	if player.is_near_stairs and Input.is_action_just_pressed("move_up"):
		finished.emit("Stairs", {"direction": player.current_stair_direction})
		return
		
	# Checa se pode descer uma escada
	if player.is_near_stairs and Input.is_action_just_pressed("move_down"):
		finished.emit("Stairs", {"direction": player.current_stair_direction})
		return
