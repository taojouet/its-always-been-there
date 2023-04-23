extends CollisionShape3D

func player_win(ground):
	if ground is Player:
		Events.emit_signal("player_touched_ground")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	pass # Replace with function body.
