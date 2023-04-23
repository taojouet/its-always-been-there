extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
#	$AnimationPlayer2.play("RESET")
#	$RootNode/Skeleton3D/Cube.set("shader_parameter/bias",0.0)
	pass # Replace with function body.


func activate(active):
	# visible = active
	print("Active", active)
	if active: 
		$AnimationPlayer2.play("Dissolve_in")
		await  $AnimationPlayer2.animation_finished
		$AnimationPlayer.play("mixamocom")
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer2.play_backwards("Dissolve_in")
