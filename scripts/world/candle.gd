class_name Candle
extends Area2D

## Cena do item a ser solto (por padrão, solta um coração)
@export var drop_item_scene: PackedScene = preload("res://scenes/items/heart.tscn")

var is_destroyed: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(_delta: float) -> void:
	if is_destroyed:
		return
		
	# Checa se algum corpo sobreposto está atacando
	for body in get_overlapping_bodies():
		_check_attack_hit(body)

func _on_body_entered(body: Node2D) -> void:
	if is_destroyed:
		return
	_check_attack_hit(body)

func _check_attack_hit(body: Node2D) -> void:
	if is_destroyed:
		return

	# 1. Verifica se o corpo é o Player e possui a State_Machine do Ítalo
	var sm = body.get_node_or_null("State_Machine")
	if sm and sm.state != null:
		# Só quebra se o jogador estiver de fato no estado de ATAQUE ("Attack")
		if sm.state.name == "Attack":
			if _is_player_facing_candle(body):
				destroy()

func _is_player_facing_candle(player: Node2D) -> bool:
	var sprite: Sprite2D = player.get_node_or_null("Sprite2D")
	var diff_x: float = global_position.x - player.global_position.x
	
	if sprite != null:
		# Se flip_h for true, Simon está olhando para a ESQUERDA
		if sprite.flip_h and diff_x > 10.0:
			return false
		# Se flip_h for false, Simon está olhando para a DIREITA
		if not sprite.flip_h and diff_x < -10.0:
			return false
			
	return true

func destroy() -> void:
	if is_destroyed:
		return
	is_destroyed = true

	# 1. Instancia o item coletável no mesmo lugar da vela
	if drop_item_scene != null:
		var item: Node2D = drop_item_scene.instantiate()
		item.global_position = global_position
		get_parent().call_deferred("add_child", item)

	# 2. Remove a vela do jogo
	queue_free()
