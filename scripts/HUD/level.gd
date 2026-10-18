extends Node

@onready var player: Player = $Player
@onready var boss: Boss = $Boss

@export var have_boss :bool
@onready var player_hp_bar: HealthBar = $HUD/PlayerUI/PlayerHealthBar
@onready var boss_hp_bar: HealthBar = $HUD/BossUI/BossHealthBar

func _ready() -> void:
	player.hp_changed.connect(player_hp_bar.update_hp)
	if have_boss:
		boss.hp_changed.connect(boss_hp_bar.update_hp)
	
	player_hp_bar.update_hp(player.current_health, player.max_health)
	if have_boss:
		boss_hp_bar.update_hp(boss.current_hp, boss.max_hp)
