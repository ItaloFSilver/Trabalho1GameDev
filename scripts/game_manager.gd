extends Node

# Valores padrão de quando o jogo começa
var player_max_hp: int = 16
var player_hp: int = 16
var player_lives: int = 3

# Função útil para quando o jogador der Game Over e o jogo reiniciar
func reset_stats() -> void:
	player_hp = player_max_hp
	player_lives = 3
