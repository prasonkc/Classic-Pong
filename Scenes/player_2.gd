extends CharacterBody2D

signal player_position(position)
signal p2_collision
const SPEED = 200
var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	emit_signal("player_position", global_position)

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("Up"):
		velocity.y -= SPEED
	if Input.is_action_pressed("Down"):
		velocity.y += SPEED

	velocity = velocity.normalized() * SPEED
	var collision = move_and_collide(velocity * delta)
	
	var screen_height = get_viewport_rect().size.y
	var paddle_height = $Sprite2D.texture.get_height()
	global_position.y = clamp(global_position.y, 50, screen_height-paddle_height + 70)
	
	if collision:
		emit_signal("p2_collision")
		global_position.x = start_position.x
		$"paddle-hit".play()
		
	emit_signal("player_position", global_position)
	
