extends CharacterBody2D
var start_position: Vector2

signal p1_collision
const SPEED = 200
const MAX_TRACK_SPEED = 150
var ball

func _ready():
	start_position = global_position
	ball = get_parent().get_node("Ball")
	
func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var rand = randi_range(0, 100)
	var missup = false
	var missdown = false

	# Random chance to miss
	if rand == 7:
		missup = true
	elif rand == 14:
		missdown = true

	if ball:
		if ball.global_position.x < global_position.x - 10:
			if missup:
				velocity.y = -50
			elif missdown:
				velocity.y = 50
		else:
			if ball.global_position.y < global_position.y - 10:
				velocity.y = -SPEED
			elif ball.global_position.y > global_position.y + 10:
				velocity.y = SPEED

	velocity = velocity.normalized() * SPEED
	var collision = move_and_collide(velocity * delta)

	global_position.y = clamp(global_position.y, 0, 620)


	if collision:
		emit_signal("p1_collision")
		global_position.x = start_position.x
		$"paddle-hit".play()
		
