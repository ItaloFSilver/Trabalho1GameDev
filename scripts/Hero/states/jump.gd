class_name JumpState
extends State

## Força do pulo e velocidade horizontal (podem ser ajustadas pelo Inspetor da Godot)
@export var jump_velocity: float = -320.0
@export var move_speed: float = 120.0

@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	player.velocity.y = jump_velocity

	var input_direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = input_direction * move_speed

	if input_direction != 0 and player.has_node("Sprite2D"):
		player.get_node("Sprite2D").flip_h = (input_direction < 0)

	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").play("jump")


func _physics_update(delta: float) -> void:
	# 1. Aplica a gravidade durante o arco do pulo
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()

	# 2. Ataque aéreo (Ataque com chicote/sub-arma durante o pulo)
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	# 3. Chegou ao ápice da subida (começou a cair) -> Transita para Fall
	if player.velocity.y >= 0:
		finished.emit("Fall", {})
		return

	# 4. Caso colida com o chão prematuramente (ex: pulou sob um teto baixo)
	if player.is_on_floor():
		if player.velocity.x != 0:
			finished.emit("Walk", {})
		else:
			finished.emit("Idle", {})
		return
