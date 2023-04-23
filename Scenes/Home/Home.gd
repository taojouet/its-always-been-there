@tool
extends Node3D

@export
var door_a_rotation = 0.0
@export
var door_b_rotation = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# rotation.y += PI * delta * 0.1
	var door_a = $DoorAParent
	var door_b = $DoorBParent
	if door_a.rotation.y != door_a_rotation:
		door_a.rotation.y = door_a_rotation
	if door_b.rotation.y != door_b_rotation:
		door_b.rotation.y = door_b_rotation
