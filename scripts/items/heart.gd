class_name Heart
extends Area2D

@export var fall_speed: float = 35.0
@export var ground_y: float = 208.0

var time_passed: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	time_passed += delta * 4.0
	
	if position.y < ground_y - 6.0:
		position.y += fall_speed * delta
		position.x += sin(time_passed) * 0.3

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body is CharacterBody2D:
		body.cure(2)
		queue_free()
