extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("mixamocom")
	pass # Replace with function body.


func activate(active):
	visible = active
	if active:
		$AnimationPlayer.play("mixamocom")
	else:
		$AnimationPlayer.stop()
