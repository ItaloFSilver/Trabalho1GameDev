extends Control

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_button_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")

func _on_button_sair_pressed() -> void:
	get_tree().quit()
