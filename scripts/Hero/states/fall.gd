# fall_state.gd
class_name FallState
extends State

@onready var player: CharacterBody2D = owner as CharacterBody2D


func enter(_previous_state: String, _data := {}) -> void:
	# Tocar a animação de queda (ou "jump", caso compartilhem o mesmo sprite no NES)
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")
		if anim_player.has_animation("fall"):
			anim_player.play("fall")
		elif anim_player.has_animation("jump"):
			anim_player.play("jump")


func _physics_update(delta: float) -> void:
	# 1. Aplica a aceleração da gravidade continuada
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()

	# 2. Ataque aéreo (Ataque no ar durante a queda)
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	# 3. Tocou o solo (Pouso)
	if player.is_on_floor():
		# Se ainda houver velocidade horizontal ao tocar o chão, continua caminhando
		if player.velocity.x != 0 and Input.get_axis("move_left", "move_right") != 0:
			finished.emit("Walk", {})
		else:
			finished.emit("Idle", {})
		return
