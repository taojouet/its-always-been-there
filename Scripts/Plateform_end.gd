extends Node3D

signal player_end_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$Drink.activate(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_playerdetection_body_entered(body):
	emit_signal("player_end_entered")
	$Drink.activate(true)
	$Drink/AnimationPlayer2.play("Dissolve_in")
	pass # Replace with function body.

