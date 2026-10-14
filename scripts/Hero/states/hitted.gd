class_name HittedState 
extends State 

@onready var player: Player = owner as Player 

@export var knockback_force := Vector2(150.0, -250.0) 

func enter(_previous_state: String, _data := {}) -> void: 
	if player.anim:
		player.anim.play("hitted") 

	var knockback_direction: float = -1.0 
	
	if _data.has("attacker_pos_x"):
		knockback_direction = sign(player.global_position.x - _data["attacker_pos_x"])
		if knockback_direction == 0:
			knockback_direction = -1.0 
	else:
		if player.sprite and player.sprite.flip_h:
			knockback_direction = 1.0 
		else:
			knockback_direction = -1.0

	player.velocity.x = knockback_force.x * knockback_direction
	player.velocity.y = knockback_force.y


func _physics_update(delta: float) -> void: 
	# 1. Aplica a gravidade para criar o arco do arremesso
	if not player.is_on_floor(): 
		player.velocity += player.get_gravity() * delta 
		

	player.move_and_slide() 

	if player.is_on_floor() and player.velocity.y >= 0:     
		# Checa as teclas para uma transição fluida ao levantar
		var input_direction := Input.get_axis("move_left", "move_right") 
		if input_direction != 0: 
			finished.emit("Walk", {}) 
		else: 
			finished.emit("Idle", {})
