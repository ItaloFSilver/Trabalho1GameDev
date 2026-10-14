class_name DeadState 
extends State 

@onready var player: Player = owner as Player 

func enter(_previous_state: String, _data := {}) -> void: 
	player.velocity.x = 0 
	
	if player.anim:
		player.anim.play("dead") 

	handle_death_sequence()

func _physics_update(delta: float) -> void: 
	if not player.is_on_floor(): 
		player.velocity += player.get_gravity() * delta 
		
	player.move_and_slide() 


func handle_death_sequence() -> void:
	await get_tree().create_timer(3.0).timeout
	
	# Recarrega a cena atual (reinicia a fase)
	get_tree().reload_current_scene()
