extends Node3D

@onready var plateform = $Plateform
const plateform_path = preload("res://Scripts/Plateform.tscn")
const NUM_PLATFORMS = 31
var plateforms = []


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		plateforms[0].translate( Vector3(0,0,len(plateforms) ) )
		plateforms.append(plateforms.pop_front())

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	for i in range(NUM_PLATFORMS):
		var p = plateform_path.instantiate()
		add_child(p)
		plateforms.append(p)
		p.translate(Vector3(0, 0, i))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

