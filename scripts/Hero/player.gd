class_name Player 
extends CharacterBody2D

@export var speed: float = 100.0
@export var jump: float = -300.0
@export var gravity: float = 900.0
var is_near_stairs := false
var current_stair_direction := Vector2.ZERO
var current_stair_snap_x := 0.0

@export var max_health: int = 16 # Castlevania clássico usa 16 pontos/barras
var current_health: int
@export var damage: int = 1 # Dano do chicote
var is_invincible := false
@export var invincibility_duration := 1.5 # Segundos piscando após tomar dano

@onready var anim: AnimationPlayer = $AnimationPlayer 
@onready var sprite: Sprite2D = $Pivot/Sprite2D
@onready var state_machine = $State_Machine # Ajuste para o nome do nó da sua máquina de estados

func _ready() -> void:
	current_health = max_health

func _process(_delta: float) -> void:
	
	pass


func take_damage(amount: int, attacker_pos_x: float) -> void:
	if is_invincible:
		return
		
	current_health -= amount
	
	if current_health <= 0:
		die()
		return
		
	start_invincibility()
	
	if state_machine:
		state_machine._transition_to_next_state("Hitted", {"attacker_pos_x": attacker_pos_x})

func start_invincibility() -> void:
	is_invincible = true
	
	if sprite:
		var blink_tween = create_tween().set_loops(int(invincibility_duration / 0.15))
		blink_tween.tween_property(sprite, "modulate:a", 0.2, 0.075)
		blink_tween.tween_property(sprite, "modulate:a", 1.0, 0.075)
	
	await get_tree().create_timer(invincibility_duration).timeout
	
	is_invincible = false
	if sprite:
		sprite.modulate.a = 1.0
		

func enter_stair_zone(stair_direction: Vector2, snap_x: float) -> void:
	is_near_stairs = true
	current_stair_direction = stair_direction
	current_stair_snap_x = snap_x

func exit_stair_zone() -> void:
	is_near_stairs = false
	current_stair_direction = Vector2.ZERO

func die() -> void:
	if state_machine:
		state_machine._transition_to_next_state("Dead") 


func _on_castle_door_transition_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_castle_door_transition_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_weapon_area_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(2)
	pass # Replace with function body.
