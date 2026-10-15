class_name State_Machine extends Node

@export var initial_State: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_State if initial_State != null else get_child(0)
).call()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	await owner.ready
	
	# 2. Busca o Player (Tenta pegar o dono da cena; se falhar, pega o pai direto)
	# 3. Busca o Player diretamente pelo nó pai
	var player = get_parent()
	
	# Verifica se o Godot reconhece o pai como a classe Player
	if not player is Player:
		printerr("ERRO: O pai da StateMachine se chama '", player.name, "' e não é da classe Player!")
		return
		
	# Se ainda for nulo, avisa no console para não o jogo não "crashar" sem explicação
	if player == null:
		printerr("ERRO: A StateMachine não conseguiu encontrar o Player!")
		return

	# 3. Varre os filhos diretos da StateMachine manualmente (evita o bug do find_children)
	for child in get_children():
		if child is State:
			child.finished.connect(_transition_to_next_state)
			child.player = player # Injeta a referência com sucesso!

	# 4. Inicia o estado inicial
	state.enter("")
	set_process(true)
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state._physics_update(delta)

func _transition_to_next_state(target_state: String, data: Dictionary = {}) -> void:
	if not has_node(target_state):
		printerr(owner.name + ": Tentou mudar para o estado " + target_state + " mas ele não existe.")
	
	var previous_state := state.name
	state.exit()
	state = get_node(target_state)
	state.enter(previous_state, data)
