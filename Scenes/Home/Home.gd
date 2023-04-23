extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_open_door_body_entered(body):
	if body is Player:
		Events.emit_signal("Door")
		$OpenDoor/CollisionShape3D.disabled = true
		$AnimationPlayer.play("open_door_a")
