class_name WalkState
extends State

@export var move_speed: float = 120.0

@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	pass


func _physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.move_and_slide()
		finished.emit("Fall", {})
		return

	if player.has_node("AnimationPlayer"):
		player.get_node("AnimationPlayer").play("walk")

	var input_direction := Input.get_axis("move_left", "move_right")

	if input_direction == 0:
		finished.emit("Idle", {})
		return

	player.velocity.x = input_direction * move_speed
	if input_direction < 0:
		player.get_node("Pivot").scale.x = -1
	else:
		player.get_node("Pivot").scale.x = 1

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
