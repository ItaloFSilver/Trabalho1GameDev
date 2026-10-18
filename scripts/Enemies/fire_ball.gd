class_name FireBall
extends Area2D

@export var speed: float = 120.0
var direction := Vector2.ZERO
@export var onScreen := true

@onready var anim: AnimationPlayer = $AnimationPlayer # ou AnimatedSprite2D
@export var pool: ObjectPool

func _ready() -> void:
	if owner is ObjectPool:
		pool = owner
	if anim:
		anim.play("growing")
		await anim.animation_finished
		

func set_direction(target_dir: Vector2) -> void:
	direction = target_dir.normalized()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	anim.play("idle")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	recycle()

func recycle() -> void:
	var pool = get_parent() as ObjectPool
	if pool:
		pool.call_deferred("return_to_pool",self)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(4, position.x)
	pass # Replace with function body.
