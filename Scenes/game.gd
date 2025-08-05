extends Node2D
signal ball_collision_y #collision with top/bottom boundary
signal ball_collision_x_left #collision with left/right boundary
signal ball_collision_x_right 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"BG-Music".play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boundary_left_body_entered(body: Node2D) -> void:
	emit_signal("ball_collision_x_left") 


func _on_boundary_right_body_entered(body: Node2D) -> void:
	emit_signal("ball_collision_x_right") 
