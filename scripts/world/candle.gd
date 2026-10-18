class_name Candle
extends Area2D

@export var drop_item_scene: PackedScene = preload("res://scenes/items/heart.tscn")
@export var hit_sound: AudioStream = preload("res://assets/audio/sfx/kill.ogg")

var is_destroyed: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(_delta: float) -> void:
	if is_destroyed:
		return
		
	for body in get_overlapping_bodies():
		_check_attack_hit(body)

func _on_body_entered(body: Node2D) -> void:
	if is_destroyed:
		return
	_check_attack_hit(body)

func _check_attack_hit(body: Node2D) -> void:
	if is_destroyed:
		return

	var sm = body.get_node_or_null("State_Machine")
	if sm and sm.state != null:
		if sm.state.name == "Attack":
			if _is_player_hitting_candle(body):
				destroy()

func _is_player_hitting_candle(player: Node2D) -> bool:
	var diff_x: float = global_position.x - player.global_position.x
	var diff_y: float = abs(global_position.y - (player.global_position.y + 20.0))
	
	if diff_y > 35.0:
		return false
		
	var is_facing_left: bool = false
	var pivot: Node2D = player.get_node_or_null("Pivot")
	var sprite: Sprite2D = player.get_node_or_null("Pivot/Sprite2D")
	if sprite == null:
		sprite = player.get_node_or_null("Sprite2D")
	if pivot != null:
		is_facing_left = pivot.scale.x < 0
		if sprite != null and sprite.flip_h:
			is_facing_left = not is_facing_left
	elif sprite != null:
		is_facing_left = sprite.flip_h
	else:
		is_facing_left = player.velocity.x < 0
		
	var whip_reach: float = 45.0
	
	if is_facing_left:
		return diff_x <= 15.0 and diff_x >= -whip_reach
	else:
		return diff_x >= -15.0 and diff_x <= whip_reach

func destroy() -> void:
	if is_destroyed:
		return
	is_destroyed = true

	if hit_sound:
		var sfx := AudioStreamPlayer.new()
		sfx.stream = hit_sound
		sfx.finished.connect(sfx.queue_free)
		get_tree().root.add_child(sfx)
		sfx.play()

	if drop_item_scene != null:
		var item: Node2D = drop_item_scene.instantiate()
		item.global_position = global_position
		get_parent().call_deferred("add_child", item)

	queue_free()
