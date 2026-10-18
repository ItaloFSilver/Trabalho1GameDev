class_name BossMove
extends State

@onready var parent: Boss = owner as Boss

var target_pos: Vector2
var move_speed: float = 80.0

func enter(_previous_state: String, _data := {}) -> void:
	if parent.waypoints.is_empty():
		printerr("Chefe sem waypoints definidos!")
		return
		
	target_pos = parent.waypoints.pick_random()
	
	while parent.waypoints.size() > 1 and parent.global_position.distance_to(target_pos) < 10.0:
		target_pos = parent.waypoints.pick_random()
		
	if parent.anim:
		parent.anim.play("idle")

func _physics_update(_delta: float) -> void:
	if parent.waypoints.is_empty():
		return
	if parent.current_hp <= 0:
		finished.emit("Die", {})
	var direction := parent.global_position.direction_to(target_pos)
	parent.velocity = direction * move_speed
	parent.move_and_slide()
	
	if parent.global_position.distance_to(target_pos) < 5.0:
		target_pos = parent.waypoints.pick_random()
		finished.emit("Attack", {})
