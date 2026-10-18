class_name Boss
extends CharacterBody2D

signal hp_changed(current: int, max_hp: int)
signal boss_defeated

@export var max_hp: int = 16
@export var waypoint_nodes: Array[Marker2D]

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
	
	if current_hp <= 0:
		pass

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_active = true
