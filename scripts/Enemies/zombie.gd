class_name Zombie
extends CharacterBody2D

@export var speed: float = 40.0
@export var gravity: float = 900.0
var has_entered_screen: bool = false

var direction: float = -1.0 
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if anim:
		anim.play("walk")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = speed * direction
	
	if sprite:
		sprite.flip_h = (direction < 0)
		
	move_and_slide()

func take_damage(_amount: int) -> void:
	var actualSpeed = speed
	speed = 0
	if anim: 
		anim.play("death")
		await anim.animation_finished
	speed = 40.0
	die_or_exit_screen()
	
func reset_state() -> void:
	if anim:
		anim.play("walk")

func die_or_exit_screen() -> void:
	var pool = get_parent() as ObjectPool
	if pool:
		pool.return_to_pool(self)


func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		body.take_damage(2, global_position.x)
	pass # Replace with function body.
	
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	has_entered_screen = true # Confirma que o zumbi já ficou visível para o jogador

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if has_entered_screen:
		die_or_exit_screen()
