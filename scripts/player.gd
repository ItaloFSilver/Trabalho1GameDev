extends Area2D

@export var x_speed: float
@export var jump: float

var ground: float
var y_speed: float
var on_air: bool
var player_base: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ground = position.y
	player_base = ground
	on_air = false
	y_speed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta: float) -> void:
	var dx = Input.get_axis("move_left", "move_right")
	
	y_speed += gravity * delta
	translate(Vector2(x_speed * dx, y_speed) * delta)
	
	if position.y > player_base:
		position.y = player_base
		on_air = false
	
	if Input.is_action_just_pressed("jump") and not on_air:
		y_speed = -jump
		on_air = true
			
