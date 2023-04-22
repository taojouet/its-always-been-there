extends Node3D

const TILE_SIZE = 20
const PLATEFORM_SCALE = 5

@onready var plateform = $Plateform
const plateform_path = preload("res://Scripts/Plateform.tscn")
const NUM_PLATFORMS = 7
var plateforms = []

		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	for i in range(NUM_PLATFORMS):
		var p = plateform_path.instantiate()
		add_child(p)
		p.scale *= PLATEFORM_SCALE
		p.connect("trigger", movePlateform)
		plateforms.append(p)
		p.translate(Vector3(0, 0, i*TILE_SIZE))
		if i == round(NUM_PLATFORMS/2):
			$Player.global_position.x=p.global_position.x
			$Player.global_position.z=p.global_position.z
		
		if i == round(NUM_PLATFORMS/2-2):
			$Slenderman.global_position.x=p.global_position.x
			$Slenderman.global_position.z=p.global_position.z
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func movePlateform(body):
	if body is Player:
		print("TRIGGER")
		plateforms[0].translate( Vector3(0,0,len(plateforms)*TILE_SIZE ) )
		plateforms[0].rand_forest()
		plateforms.append(plateforms.pop_front())
