class_name State_Machine extends Node

@export var initial_State: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_State if initial_State != null else get_child(0)
).call()

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	
	# Substituímos o "await" pelo "call_deferred" para fugir do travamento infinito
	call_deferred("_start_machine")

func _start_machine() -> void:
	var parent_node = get_parent()
	
	for child in get_children():
		if child is State:
			child.finished.connect(_transition_to_next_state)
			
			if parent_node is Player:
				child.set("player", parent_node)
			elif parent_node is Boss:
				child.set("boss", parent_node)
				child.set("parent", parent_node)

	if state:
		print(">>> FSM Ligada com sucesso no personagem: " + parent_node.name + " | Estado: " + state.name)
		state.enter("")
		set_process(true)
		set_physics_process(true)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state._physics_update(delta)

func _transition_to_next_state(target_state: String, data: Dictionary = {}) -> void:
	if not has_node(target_state):
		printerr("ERRO: Tentou mudar para o estado " + target_state + " mas ele não existe.")
		return
		
	var previous_state := state.name
	state.exit()
	state = get_node(target_state)
	
	print(">>> " + get_parent().name + " mudou para: " + state.name)
	state.enter(previous_state, data)
