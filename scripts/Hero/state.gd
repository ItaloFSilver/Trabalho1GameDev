class_name State
extends Node

#emite o sinal de que o estado foi encerrado e deve ser alterado para o seguinte
signal finished(next_state: String, data: Dictionary)

#chamado pela máquina de estados para tratar eventos de entrada
func handle_input(_event: InputEvent) -> void:
	pass 

#chamado pela máquina de estados no loop principal
func update(_delta: float) -> void:
	pass

#chamado pela máquina de estados na atualização da física
func _physics_update(_delta: float) -> void:
	pass

func enter(previous_state: String, data:= {}) -> void:
	pass

#chamada pela máquina de estados antes da troca para o estado seguinte
#para limpar os dados do estado
func exit() -> void:
	pass
