extends CharacterBody2D

var is_moving = false
@export var speed = 300.0
var speed_increment = 50
var max_speed = 1000
var time_elapsed = 0.0
var increase_interval = 10
var player2_position
var rand
var x_direction = -1  # -1 = left, 1 = right
var y_direction = 1 #1=down, -1 = up
var boundary_ball_collision_y
var boundary_ball_collision_x

func _ready():
	player2_position = get_parent().get_node("Player2")
	player2_position.connect("player_position", _on_player2_ready)
	
	var player2 = get_parent().get_node("Player2")
	player2.connect("p2_collision", Callable(self, "_on_p2_collision"))
	
	var player1 = get_parent().get_node("Player1")
	player1.connect("p1_collision", Callable(self, "_on_p1_collision"))

	boundary_ball_collision_y = get_parent()
	boundary_ball_collision_y.connect("ball_collision_y", Callable(self, "_on_ball_collision_y"))
	
	boundary_ball_collision_x = get_parent()
	boundary_ball_collision_x.connect("ball_collision_x", Callable(self, "_on_ball_collision_x"))

	rand = randi_range(-70, 70)

func _on_player2_ready(_position):
	global_position = Vector2(_position.x - 30, _position.y)
	if Input.is_action_just_pressed("Shoot"):
		is_moving = true
		player2_position.disconnect("player_position", Callable(self, "_on_player2_ready"))

func _process(delta):
	if is_moving:
		time_elapsed += delta
		
	if time_elapsed >= increase_interval:
		time_elapsed = 0
		speed = min(speed + speed_increment, max_speed)
		
	var velocity = Vector2(speed * x_direction, rand * y_direction)
	position.x += speed * delta * x_direction
	position.y += rand * delta * y_direction

func _on_p1_collision():
	x_direction = 1  # bounce right
	rand = randi_range(-70, 70) 

func _on_p2_collision():
	x_direction = -1
	rand = randi_range(-70,70)
	
func _on_ball_collision_y():
	y_direction *= -1
	$"wall-bounce".play()

func _on_ball_collision_x():
	player2_position = get_parent().get_node("Player2")
	player2_position.connect("player_position", _on_player2_ready)
	speed = 300
	$score.play()
