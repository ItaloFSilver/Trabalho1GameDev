class_name IdleState
extends State


@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	
	player.velocity.x = 0


func _physics_update(delta: float) -> void:
	
	player.anim.play("idle")
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.move_and_slide()
		finished.emit("Fall", {})
		return

	player.move_and_slide()

	
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	if Input.is_action_just_pressed("jump"):
		finished.emit("Jump", {})
		return

	if Input.is_action_pressed("move_down"):
		finished.emit("Crouch", {})
		return

	
	var input_direction := Input.get_axis("move_left", "move_right")
	if input_direction != 0:
		finished.emit("Walk", {})
		return
		
	if player.is_near_stairs and Input.is_action_just_pressed("move_up"):
		finished.emit("Stairs", {"direction": player.current_stair_direction})
		return
		
	if player.is_near_stairs and Input.is_action_just_pressed("move_down"):
		finished.emit("Stairs", {"direction": player.current_stair_direction})
		return
