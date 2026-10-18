class_name BossAttack
extends State

@onready var parent: Boss = get_parent().get_parent() as Boss

@export var cooldown_time: float = 1.5
@export var shoot_y_offset: float = -30.0 

func enter(_previous_state: String, _data := {}) -> void:
	if parent.current_hp <= 0:
		finished.emit("Die", {})
	parent.velocity = Vector2.ZERO
	# 1. Dá o play na animação, mas NÃO trava o código esperando ela acabar
	if parent.anim:
		parent.anim.play("attack")
	
	shoot_fireball()
	
	await parent.anim.animation_finished
	
	finished.emit("Move", {})

func shoot_fireball() -> void:
	if not parent.player or not parent.fireball_pool:
		return
		
	var fb = parent.fireball_pool.get_from_pool() 
	if fb == null:
		return
		
	var spawn_pos = parent.global_position + Vector2(0, shoot_y_offset)
	fb.global_position = spawn_pos
	
	var dir_to_player = spawn_pos.direction_to(parent.player.global_position)
	fb.set_direction(dir_to_player)
