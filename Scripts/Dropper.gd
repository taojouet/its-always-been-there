extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
#	await get_tree().create_timer(0.1).timeout
	$Player/Camera3D.global_rotation_degrees = Vector3(-90,0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
