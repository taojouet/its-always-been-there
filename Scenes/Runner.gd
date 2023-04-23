extends Node3D

const TILE_SIZE = 20
const PLATEFORM_SCALE = 5

@onready var plateform = $Plateform
const plateform_path = preload("res://Scripts/Plateform.tscn")
const NUM_PLATFORMS = 15
var platforms = []

@onready var player_start_pos = $Player.position
@onready var slenderman_start_pos = $Slenderman.position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	create_platforms()	
	$Slenderman.connect("slenderman_catch", death)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func movePlateform():
	platforms[0].translate( Vector3(0,0,len(platforms)*TILE_SIZE ) )
	platforms[0].rand_forest()
	platforms.append(platforms.pop_front())

func death():
	$Player.global_position = player_start_pos
	restart()

func erase_platforms():
	for i in range(len(platforms)):
		platforms[i].queue_free()
	platforms = []

func create_platforms():
	for i in range(NUM_PLATFORMS):
		var p = plateform_path.instantiate()
		add_child(p)
		p.scale *= PLATEFORM_SCALE
		p.connect("player_entered",movePlateform)
		platforms.append(p)
		p.translate(Vector3(0, 0, i*TILE_SIZE))
		if i<round(NUM_PLATFORMS/2):
			p.can_trigger = false

func restart():
	erase_platforms()
	$Player.position = player_start_pos
	$Slenderman.activate(false)
	$Slenderman.position = slenderman_start_pos
	create_platforms()


func _on_activate_slenderman_body_entered(body):
	if body is Player:
		$Slenderman.activate(true)
	pass # Replace with function body.
