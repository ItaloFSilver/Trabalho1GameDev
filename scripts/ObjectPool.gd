class_name ObjectPool
extends Node

@export var object_scene: PackedScene
@export var pool_size: int

var available_objects: Array[Node2D] = []

func _ready() -> void:
	for i in range(pool_size):
		var obj = object_scene.instantiate() as Node2D
		_deactivate_object(obj)
		add_child(obj)
		available_objects.append(obj)

func get_from_pool() -> Node2D:
	if available_objects.is_empty():
		return null
		
	# Pega e remove o último objeto disponível da pilha
	var obj = available_objects.pop_back()
	if obj:
		obj.show()
		obj.process_mode = Node.PROCESS_MODE_INHERIT
		
	return obj

func return_to_pool(obj: Node2D) -> void:
	if obj == null:
		return
		
	if obj.process_mode == Node.PROCESS_MODE_DISABLED or available_objects.has(obj):
		return
		
	_deactivate_object(obj)
	available_objects.append(obj)

func _deactivate_object(obj: Node2D) -> void:
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	obj.hide()
