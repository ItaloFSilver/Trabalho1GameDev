@tool
class_name Staircase
extends Node2D

@export_range(2, 20) var step_count: int = 4:
	set(value):
		step_count = value
		_rebuild_stairs()

@export_enum("Direita:1", "Esquerda:-1") var climb_direction_x: int = 1:
	set(value):
		climb_direction_x = value
		_rebuild_stairs()

@export var step_size: Vector2 = Vector2(16, 16)
@export var step_texture: Texture2D = preload("res://assets/environment/stair_castlevania_step.png")

@onready var steps_visual: Node2D = $StepsVisual
@onready var bottom_entry: Area2D = $BottomEntry
@onready var top_entry: Area2D = $TopEntry

func _ready() -> void:
	_rebuild_stairs()

func _rebuild_stairs() -> void:
	if not has_node("StepsVisual") or not has_node("BottomEntry") or not has_node("TopEntry"):
		return
		
	var visual_node := get_node("StepsVisual")
	var b_entry := get_node("BottomEntry") as Area2D
	var t_entry := get_node("TopEntry") as Area2D
	
	for child in visual_node.get_children():
		child.queue_free()
		
	for i in range(step_count):
		var step_sprite := Sprite2D.new()
		step_sprite.texture = step_texture
		step_sprite.centered = true
		step_sprite.flip_h = (climb_direction_x < 0)
		
		var pos_x = i * step_size.x * climb_direction_x
		var pos_y = -i * step_size.y
		step_sprite.position = Vector2(pos_x, pos_y)
	
		visual_node.add_child(step_sprite)
		
		b_entry.position = Vector2(0, 0)
		b_entry.set_meta("is_top_entry", false)
		b_entry.set_meta("climb_vector", Vector2(climb_direction_x, -1))
		b_entry.set_meta("snap_x", global_position.x)
		b_entry.set_meta("snap_y", global_position.y) # <- NOVA LINHA
	
		var top_x = (step_count - 1) * step_size.x * climb_direction_x
		var top_y = -(step_count - 1) * step_size.y
		t_entry.position = Vector2(top_x, top_y)
		t_entry.set_meta("is_top_entry", true)
		t_entry.set_meta("climb_vector", Vector2(climb_direction_x, -1))
		t_entry.set_meta("snap_x", global_position.x + top_x)
		t_entry.set_meta("snap_y", global_position.y + top_y)
	
func _on_bottom_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		var dir: Vector2 = bottom_entry.get_meta("climb_vector")
		var snap_x: float = bottom_entry.get_meta("snap_x") - 8
		var snap_y: float = bottom_entry.get_meta("snap_y")
		var is_top: bool = bottom_entry.get_meta("is_top_entry")
		body.enter_stair_zone(dir, snap_x, snap_y, is_top)
		 

func _on_bottom_entry_body_exited(body: Node2D) -> void:
	if body is Player:
		body.exit_stair_zone()

func _on_top_entry_body_entered(body: Node2D) -> void:
	if body is Player:
		var dir: Vector2 = top_entry.get_meta("climb_vector")
		var snap_x: float = top_entry.get_meta("snap_x") - 8
		var snap_y: float = top_entry.get_meta("snap_y")
		var is_top: bool = top_entry.get_meta("is_top_entry")
		body.enter_stair_zone(dir, snap_x, snap_y, is_top)
		
func _on_top_entry_body_exited(body: Node2D) -> void:
	if body is Player:
		body.exit_stair_zone()
