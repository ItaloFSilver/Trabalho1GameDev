class_name ZombieSpawner
extends Node2D

@export var camera: Camera2D 
@export var spawn_offset_x: float = 250.0 
@onready var pool: ObjectPool = $ObjectPool 

@onready var spawn_left: Marker2D = $SpawnLeft
@onready var spawn_right: Marker2D = $SpawnRight

func _ready() -> void:
	if spawn_left:
		spawn_left.position.x = -spawn_offset_x
	if spawn_right:
		spawn_right.position.x = spawn_offset_x

func _process(_delta: float) -> void:
	if camera:
		global_position.x = camera.get_screen_center_position().x

func _on_timer_timeout() -> void:
	spawn_zombie()

func get_ground_position(marker: Marker2D) -> Vector2:
	var space_state = get_world_2d().direct_space_state
	
	var ray_start = marker.global_position
	var ray_end = marker.global_position + Vector2(0, 120)
	
	var query = PhysicsRayQueryParameters2D.create(ray_start, ray_end, 1)
	var result = space_state.intersect_ray(query)
	
	if result:
		return result.position
		
	return Vector2.ZERO
	
func spawn_zombie() -> void:
	var chosen_marker = spawn_left if randi() % 2 == 0 else spawn_right
	var spawn_pos = get_ground_position(chosen_marker)
	
	if spawn_pos == Vector2.ZERO:
		chosen_marker = spawn_right if chosen_marker == spawn_left else spawn_left
		spawn_pos = get_ground_position(chosen_marker)
		
	if spawn_pos == Vector2.ZERO:
		return
	var zombie = pool.get_from_pool()
	
	if zombie == null:
		return
	print("zombie spawned")
	zombie.global_position = chosen_marker.global_position
	
	if chosen_marker == spawn_left:
		zombie.direction = 1.0
	else:
		zombie.direction = -1.0
		
	if zombie.has_method("reset_state"):
		zombie.reset_state()
