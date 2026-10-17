extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var anim:AnimationPlayer

func _ready()-> void:
	anim = $AnimationPlayer
	anim.play("idle")

func _physics_process(delta: float) -> void:
	pass

func take_damage(dmg: float) -> void:
	pass
