class_name Stairs
extends State 

var player: Player 

var stair_direction := Vector2.ZERO 
var stair_speed := 50.0 
var climb_time := 0.0

func enter(_previous_state: String, data := {}) -> void: 
	player.velocity = Vector2.ZERO 
	climb_time = 0.0
	
	if data.has("direction"):
		stair_direction = data["direction"]
			
	player.global_position.x = player.current_stair_snap_x
	player.set_collision_mask_value(1, false)
	
	if player.anim:
		player.anim.play("climbing_up") 

func _physics_update(delta: float) -> void: 
	climb_time += delta
	var input_y := Input.get_axis("move_up", "move_down") 
	
	if input_y < 0:
		player.velocity = Vector2(stair_direction.x, -1).normalized() * stair_speed
		
		if player.anim:
			player.anim.play("walk")
			player.sprite.flip_h = (stair_direction.x < 0)
			
	elif input_y > 0:
		player.velocity = Vector2(-stair_direction.x, 1).normalized() * stair_speed
		
		if player.anim:
			player.anim.play("walk")
			player.get_node("Pivot").scale.x = -1
				 
	else: 
		player.velocity = Vector2.ZERO
		if player.anim and player.anim.is_playing():
			player.anim.pause() 

	player.move_and_slide() 
	
	if Input.is_action_just_pressed("attack"): 
		finished.emit("Attack", {"on_stairs": true, "direction": stair_direction}) 
		return

	if climb_time > 0.1: 
		if not player.current_stair_is_top and not player.is_near_stairs and input_y > 0:
			finished.emit("Idle", {})
			return
			
		if player.current_stair_is_top and not player.is_near_stairs and input_y < 0:
			player.global_position.y -= 2.0 
			finished.emit("Idle", {})
			return

func exit() -> void:
	player.set_collision_mask_value(1, true)
