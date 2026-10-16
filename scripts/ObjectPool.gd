class_name ObjectPool
extends Node

@export var object_scene: PackedScene
@export var pool_size: int = 2

var objects: Array[Node2D] = []
var available_count: int = 0

func _ready() -> void:
	# Preenche o array com as instâncias inativas
	for i in range(pool_size):
		var obj = object_scene.instantiate() as Node2D
		obj.process_mode = Node.PROCESS_MODE_DISABLED
		obj.hide()
		add_child(obj)
		objects.append(obj)
		
	available_count = pool_size

func get_from_pool() -> Node2D:
	# Segurança: Se não há mais objetos na pool, retorna nulo
	if available_count <= 0:
		return null
		
	available_count -= 1
	# Pega sempre o último objeto disponível no array
	var obj = objects[available_count] 
	
	if obj:
		obj.show()
		# PROCESS_MODE_INHERIT faz ele voltar a rodar normalmente na física
		obj.process_mode = Node.PROCESS_MODE_INHERIT 
	
	return obj

func return_to_pool(obj: Node2D) -> void:
	# Reseta o objeto e devolve para a pool
	obj.process_mode = Node.PROCESS_MODE_DISABLED
	obj.hide()
	
	# Devolve o objeto para a posição correta no array
	objects[available_count] = obj
	available_count += 1
