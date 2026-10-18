class_name DoorTransition
extends Area2D

@export_file("*.tscn") var target_scene: String = "res://scenes/castle_interior.tscn"

@export var transition_sound: AudioStream = preload("res://assets/audio/sfx/rise.ogg")

@export var fade_duration: float = 0.5

@onready var fade_rect: ColorRect = $FadeLayer/FadeRect
@onready var sfx_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _is_transitioning: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if fade_rect:
		fade_rect.modulate.a = 0.0

func _on_body_entered(body: Node2D) -> void:
	if _is_transitioning:
		return
		
	if body.name == "Player":
		_start_transition()

func _start_transition() -> void:
	_is_transitioning = true
	
	if transition_sound and sfx_player:
		sfx_player.stream = transition_sound
		sfx_player.play()
		
	if fade_rect:
		var tween := create_tween()
		tween.tween_property(fade_rect, "modulate:a", 1.0, fade_duration)
		tween.tween_callback(_change_scene)
	else:
		_change_scene()

func _change_scene() -> void:
	if target_scene != "" and ResourceLoader.exists(target_scene):
		get_tree().change_scene_to_file(target_scene)
	else:
		push_warning("DoorTransition: Cena de destino inválida: " + target_scene)
