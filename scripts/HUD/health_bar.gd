class_name HealthBar
extends HBoxContainer

@export var filled_texture: Texture2D
@export var empty_texture: Texture2D

var _current_max_hp := 0

func update_hp(current_hp: int, max_hp: int) -> void:
	if max_hp != _current_max_hp:
		_build_bar(max_hp)
		
	var blocks := get_children()
	
	var valid_index := 0 
	
	for child in blocks:
		var block = child as TextureRect
		if block == null or block.is_queued_for_deletion():
			continue
			
		if valid_index < current_hp:
			block.texture = filled_texture
		else:
			block.texture = empty_texture
			
		valid_index += 1

func _build_bar(max_hp: int) -> void:
	_current_max_hp = max_hp
	
	for child in get_children():
		remove_child(child)
		child.queue_free()  
		
	for i in range(max_hp):
		var rect := TextureRect.new()
		rect.texture = filled_texture
		rect.stretch_mode = TextureRect.STRETCH_KEEP
		add_child(rect)
