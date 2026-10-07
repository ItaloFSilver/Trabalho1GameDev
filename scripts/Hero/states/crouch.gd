# crouch_state.gd
class_name CrouchState
extends State

@onready var player: CharacterBody2D = owner as CharacterBody2D


func enter(_previous_state: String, _data := {}) -> void:
	# 1. Parar completamente a movimentação horizontal ao abaixar
	player.velocity.x = 0

	# 2. Tocar a animação de agachar
	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").play("crouch")


func _physics_update(delta: float) -> void:
	# 1. Aplica a gravidade para garantir que permaneça colado ao chão
	#if not player.is_on_floor():
	#	player.velocity += player.get_gravity() * delta
	#	player.move_and_slide()
	#	finished.emit("Fall", {})
	#	return

	player.move_and_slide()

	# --- CHECAGEM DE TRANSIÇÕES ---

	# 2. Atacar abaixado (Passa 'crouched = true' para o estado de Attack saber qual animação tocar)
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {"crouched": true})
		return

	# 3. Pular a partir do estado agachado
	if Input.is_action_just_pressed("jump"):
		finished.emit("Jump", {})
		return

	# 4. Soltou o botão de agachar (Seta para baixo / S)
	if not Input.is_action_pressed("move_down"):
		# Se já estiver segurando uma direção ao levantar, vai para o Walk; senão, para no Idle
		var input_direction := Input.get_axis("move_left", "move_right")
		if input_direction != 0:
			finished.emit("Walk", {})
		else:
			finished.emit("Idle", {})
		return
