class_name Stairs
extends State 

@onready var player: Player = owner as Player 

var stair_direction := Vector2.ZERO 
var stair_speed := 50.0 # O movimento na escada é mais lento que o Walk normal

func enter(_previous_state: String, data := {}) -> void: 
	player.velocity = Vector2.ZERO     
	player.set_collision_mask_value(1, false)
	
	if data.has("direction"):
		stair_direction = data["direction"]
	player.global_position.x = player.current_stair_snap_x
	
	if player.anim:
		player.anim.play("climbing_up") # ou down, dependendo do input

func _physics_update(_delta: float) -> void: 
	var input_y := Input.get_axis("move_up", "move_down") 
	
	if input_y < 0: # Pressionando CIMA
		player.velocity = Vector2(stair_direction.x, -1).normalized() * stair_speed
		
		if player.anim:
			player.anim.play("walk")
			
	elif input_y > 0: # Pressionando BAIXO
		player.velocity = Vector2(-stair_direction.x, 1).normalized() * stair_speed
		
		if player.anim:
			player.anim.play("walk")
			
	else: 
		player.velocity = Vector2.ZERO
		if player.anim and player.anim.is_playing():
			player.anim.pause() 

	player.move_and_slide() 

	if Input.is_action_just_pressed("attack"): 
		finished.emit("Attack", {"on_stairs": true, "direction": stair_direction}) 
		return

	if player.is_on_floor() and input_y > 0:
		finished.emit("Idle", {})
		return
	
	if not player.is_near_stairs:
		finished.emit("Idle", {})
	# Como o jogador não pode pular, a saída do estado acontece quando 
	# ele atinge as Area2Ds invisíveis no topo ou no pé da escada.
	# Essa transição geralmente é forçada por fora (por um sinal da Area2D)
	# Exemplo: state_machine.transition_to("Idle")
func exit() -> void:
	player.set_collision_mask_value(1, true)
