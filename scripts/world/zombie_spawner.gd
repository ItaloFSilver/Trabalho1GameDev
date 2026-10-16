class_name ZombieSpawner
extends Node2D

# Referência direta para a Pool que criamos acima
@onready var pool: ObjectPool = $ObjectPool 

@onready var spawn_left: Marker2D = $SpawnLeft
@onready var spawn_right: Marker2D = $SpawnRight

func _on_timer_timeout() -> void:
	spawn_zombie()

func spawn_zombie() -> void:
	# Tenta pegar um zumbi da pool
	var zombie = pool.get_from_pool()
	
	# Se retornou null, a pool está vazia (já tem 5 na tela), então aborta
	if zombie == null:
		return
		
	var chosen_marker = spawn_left if randi() % 2 == 0 else spawn_right
	zombie.global_position = chosen_marker.global_position
	
	# IMPORTANTE: Como o zumbi é reutilizado, precisamos resetar variáveis dele (vida, direção)
	if chosen_marker == spawn_left:
		zombie.direction = 1.0
	else:
		zombie.direction = -1.0
		
	# Chama uma função de reset no zumbi (explicada abaixo)
	if zombie.has_method("reset_state"):
		zombie.reset_state()
