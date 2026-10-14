class_name AttackState extends State

@onready var player: CharacterBody2D = owner as CharacterBody2D


func enter(_previous_state: String, _data := {}) -> void:
	# Parar completamente a movimentação horizontal ao abaixar
	player.velocity.x = 0
	
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")

		# Conecta o sinal 'animation_finished' para disparar a função apenas UMA vez
		if not anim_player.animation_finished.is_connected(_on_animation_finished):
			anim_player.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
		anim_player.play("attack")

func _physics_update(delta: float) -> void:
	# Aplica a gravidade para garantir que permaneça colado ao chão
	#if not player.is_on_floor():
	#	player.velocity += player.get_gravity() * delta
	#	player.move_and_slide()
	#	finished.emit("Fall", {})
	#	return

	player.move_and_slide()
	

func _on_animation_finished(anim_name: StringName) -> void:
	# Garante que só reage se a animação finalizada for a de ataque
	if anim_name == "attack":
		#if not player.is_on_floor():
			#finished.emit("Fall", {})
		#else:
			finished.emit("Idle", {})


func exit() -> void:
	# Limpeza preventiva: se o estado for interrompido antes do fim, desconecta o sinal
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")
		if anim_player.animation_finished.is_connected(_on_animation_finished):
			anim_player.animation_finished.disconnect(_on_animation_finished)
