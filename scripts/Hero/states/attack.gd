class_name AttackState extends State

@onready var player: Player = owner as Player


func enter(_previous_state: String, _data := {}) -> void:
	
	player.velocity.x = 0
	
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")

		if not anim_player.animation_finished.is_connected(_on_animation_finished):
			anim_player.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
		anim_player.play("attack")

func _physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	player.move_and_slide()
	

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		finished.emit("Idle", {})


func exit() -> void:
	if player.has_node("AnimationPlayer"):
		var anim_player: AnimationPlayer = player.get_node("AnimationPlayer")
		if anim_player.animation_finished.is_connected(_on_animation_finished):
			anim_player.animation_finished.disconnect(_on_animation_finished)
