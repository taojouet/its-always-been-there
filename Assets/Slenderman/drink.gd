extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func activate(active):
	visible = active
	if active:
		$AnimationPlayer.play("mixamocom")
		await $AnimationPlayer.animation_finished("mixamocom")
		$AnimationPlayer.stop()
	else:
		$AnimationPlayer.stop()
