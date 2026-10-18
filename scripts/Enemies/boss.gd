class_name Boss
extends CharacterBody2D

signal hp_changed(current: int, max_hp: int)
signal boss_defeated

@export var max_hp: int = 16
@export var waypoint_nodes: Array[Marker2D]
@export var player: Player 
@onready var fireball_pool = $FireBallPool 

var current_hp: int
var waypoints: Array[Vector2] = []
var is_active := false

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	current_hp = max_hp
	
	for marker in waypoint_nodes:
		if marker != null:
			waypoints.append(marker.global_position)

func take_damage(amount: int) -> void:
	current_hp -= amount
	hp_changed.emit(current_hp, max_hp)
	if sprite:
		var blink_tween = create_tween().set_loops(int(1 / 0.15))
		blink_tween.tween_property(sprite, "modulate:a", 0.2, 0.075)
		blink_tween.tween_property(sprite, "modulate:a", 1.0, 0.075)
	
	await get_tree().create_timer(1).timeout

	if sprite:
		sprite.modulate.a = 1.0
	if current_hp <= 0:
		anim.play("die")
		await anim.animation_finished
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/vitoria.tscn")

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_active = true
