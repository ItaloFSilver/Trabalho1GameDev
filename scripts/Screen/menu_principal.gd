extends Control

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_button_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")

func _on_button_sair_pressed() -> void:
	get_tree().quit()

func _on_button_instrucoes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/instrucoes.tscn")

func _on_button_referencia_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/referencias.tscn")
