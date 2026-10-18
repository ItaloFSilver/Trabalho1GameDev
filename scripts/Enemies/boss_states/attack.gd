class_name BossAttack
extends State

@onready var parent: Boss = owner as Boss

@export var cooldown_time: float = 1.5

func enter(_previous_state: String, _data := {}) -> void:
	parent.velocity = Vector2.ZERO
	
	if parent.anim:
		parent.anim.play("attack")
		await parent.anim.animation_finished
		
	#await get_tree().create_timer(cooldown_time).timeout
	
	finished.emit("Move", {})
