class_name Player_State extends State

const FALLING = "falling"
const JUMP = "jump"
const IDLE = "idle"
const ATTACK = "attack"
const WALK = "walk"

var player : Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
