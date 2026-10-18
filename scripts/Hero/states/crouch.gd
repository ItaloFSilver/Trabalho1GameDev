# crouch_state.gd
class_name CrouchState
extends State

@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	
	player.velocity.x = 0
	
	player.anim.play("crouch")


func _physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.move_and_slide()
		finished.emit("Fall", {})
		return

	player.move_and_slide()

	
	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {"crouched": true})
		return

	if Input.is_action_just_pressed("jump"):
		finished.emit("Jump", {})
		return

	if not Input.is_action_pressed("move_down"):
		# Se já estiver segurando uma direção ao levantar, vai para o Walk; senão, para no Idle
		var input_direction := Input.get_axis("move_left", "move_right")
		if input_direction != 0:
			finished.emit("Walk", {})
		else:
			finished.emit("Idle", {})
		return
