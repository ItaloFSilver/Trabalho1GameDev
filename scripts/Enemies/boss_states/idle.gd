class_name BossIdle
extends State

@onready var parent: Boss = owner as Boss

func enter(_previous_state: String, _data := {}) -> void:
	parent.velocity = Vector2.ZERO
	
	if parent.anim and parent.anim.has_animation("idle"):
		parent.anim.play("idle")

func _physics_update(_delta: float) -> void:
	if parent.is_active:
		finished.emit("Move", {})
