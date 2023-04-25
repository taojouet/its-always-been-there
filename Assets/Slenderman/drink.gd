extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
#	$AnimationPlayer2.play("RESET")
#	$RootNode/Skeleton3D/Cube.set("shader_parameter/bias",0.0)
	pass # Replace with function body.


func activate(active):
	if active: 
		$RootNode/Skeleton3D/BoneAttachment3D/GlassStl2.get_surface_override_material(0).next_pass = null
		$AnimationPlayer2.play("Dissolve_in")
		await  $AnimationPlayer2.animation_finished
		$AnimationPlayer.play("mixamocom")
		$RootNode/Skeleton3D/BoneAttachment3D/GlassStl2.drink(5.0)
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer2.play_backwards("Dissolve_in")
