extends Node3D

signal player_end_entered
signal player_animation_end_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$Drink.activate(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_playerdetection_body_entered(body):
	emit_signal("player_end_entered")
	pass # Replace with function body.




func _on_area_3d_body_entered(body : Node3D):
	print("active : ", $Drink.is_visible_in_tree())
	print("other node collided : ", body.name)
	pass # Replace with function body.
	$Drink.activate(true)
