# fall_state.gd
class_name FallState
extends State

@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")
		if anim_player.has_animation("fall"):
			anim_player.play("fall")
		elif anim_player.has_animation("jump"):
			anim_player.play("jump")


func _physics_update(delta: float) -> void:
	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()

	if Input.is_action_just_pressed("attack"):
		finished.emit("Attack", {})
		return

	
	if player.is_on_floor():
		
		if player.velocity.x != 0 and Input.get_axis("move_left", "move_right") != 0:
			finished.emit("Walk", {})
		else:
			finished.emit("Idle", {})
		return
