extends Node2D
signal ball_collision_y #collision with top/bottom boundary
signal ball_collision_x #collision with left/right boundary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"BG-Music".play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boundary_top_btm_body_entered(body: Node2D) -> void:
	if(body.name == "Ball"):
		emit_signal("ball_collision_y")



func _on_boundary_lef_rig_body_entered(body: Node2D) -> void:
	emit_signal("ball_collision_x")
