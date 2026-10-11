class_name Candle
extends Area2D

## Cena do item a ser solto (por padrão, solta um coração)
@export var drop_item_scene: PackedScene = preload("res://scenes/items/heart.tscn")
@export var hit_sound: AudioStream = preload("res://assets/audio/sfx/kill.ogg")

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
			if _is_player_hitting_candle(body):
				destroy()

func _is_player_hitting_candle(player: Node2D) -> bool:
	var diff_x: float = global_position.x - player.global_position.x
	var diff_y: float = abs(global_position.y - (player.global_position.y + 20.0))
	
	# Checagem vertical: o chicote atinge na altura do corpo do Simon
	if diff_y > 35.0:
		return false
		
	var sprite: Sprite2D = player.get_node_or_null("Sprite2D")
	var is_facing_left: bool = false
	if sprite != null:
		is_facing_left = sprite.flip_h
	else:
		is_facing_left = player.velocity.x < 0
		
	# Alcance do chicote clássico (~45 pixels)
	var whip_reach: float = 45.0
	
	if is_facing_left:
		# Simon batendo para a ESQUERDA: vela deve estar à esquerda (diff_x <= 15)
		return diff_x <= 15.0 and diff_x >= -whip_reach
	else:
		# Simon batendo para a DIREITA: vela deve estar à direita (diff_x >= -15)
		return diff_x >= -15.0 and diff_x <= whip_reach

func destroy() -> void:
	if is_destroyed:
		return
	is_destroyed = true

	# 1. Toca som clássico de destruição / chicotada
	if hit_sound:
		var sfx := AudioStreamPlayer.new()
		sfx.stream = hit_sound
		sfx.finished.connect(sfx.queue_free)
		get_tree().root.add_child(sfx)
		sfx.play()

	# 2. Instancia o item coletável no mesmo lugar da vela
	if drop_item_scene != null:
		var item: Node2D = drop_item_scene.instantiate()
		item.global_position = global_position
		get_parent().call_deferred("add_child", item)

	# 3. Remove a vela do jogo
	queue_free()
