class_name State_Machine extends Node

@export var initial_State: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_State if initial_State != null else get_child(0)
).call()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")

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
