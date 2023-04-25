extends Node3D

signal end_dissolve

var door_opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("RESET")
	pass # Replace with function body.




func _on_open_door_body_entered(body):
	if !door_opened and body is Player:
		Events.emit_signal("Door")
		$OpenDoor/CollisionShape3D.disabled = true
		$AnimationPlayer.play("open_door_a")

func dissolve():
	$AnimationPlayer.play("Dissolve")
	await $AnimationPlayer.animation_finished
	emit_signal("end_dissolve")
	queue_free()
