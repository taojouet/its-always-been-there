extends Node3D

const TILE_SIZE = 20
const PLATEFORM_SCALE = 5

const platform_path = preload("res://Scripts/Plateform.tscn")
const NUM_PLATFORMS = 3
const NB_PLATFORM_TO_END = 4

const PLATFORM_END_PATH = preload("res://Scripts/Plateform_end.tscn")

var count_platform_pass = 0
var platforms = []

var reached_end_platform = false

@onready var player_start_pos = $Player.position
@onready var slenderman_start_pos = $Slenderman.position

# Called when the node enters the scene tree for the first time.
func _ready():
	create_platforms()	
	$Slenderman.connect("slenderman_catch", death)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Slenderman.is_active:
		$Slenderman.position.x = lerp($Slenderman.position.x,$Player.position.x,0.05)
	pass

func movePlateform():
	if not reached_end_platform:
		platforms[0].translate( Vector3(0,0,len(platforms)*TILE_SIZE ) )
		platforms[0].rand_forest()
		platforms.append(platforms.pop_front())
		count_platform_pass+=1
		end_platform_refresh()
	

func death():
#	$Player.global_position = player_start_pos
	restart()

func erase_platforms():
	for i in range(len(platforms)):
		platforms[i].queue_free()
	platforms = []

func create_platforms():
	reached_end_platform = false
	for i in range(NUM_PLATFORMS):
		var p = platform_path.instantiate()
		add_child(p)
		p.scale *= PLATEFORM_SCALE
		p.connect("player_entered",movePlateform)
		platforms.append(p)
		p.translate(Vector3(0, 0, i*TILE_SIZE))
		if i<round(NUM_PLATFORMS/2):
			p.can_trigger = false

func restart():
	erase_platforms()
	$Slenderman.activate(false)
	$Slenderman.position = slenderman_start_pos
#	$Player.position = player_start_pos
	create_tween().tween_property($Player,"rotation_degrees",Vector3(0,180,0),1.0).set_ease(Tween.EASE_IN)
	await create_tween().tween_property($Player,"position",player_start_pos,1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished
	create_platforms()


func _on_activate_slenderman_body_entered(body):
	if body is Player:
		$Slenderman.activate(true)
	pass # Replace with function body.

func end_platform_refresh():
	
	if count_platform_pass >= NB_PLATFORM_TO_END:
		reached_end_platform = true
		var platform_end = PLATFORM_END_PATH.instantiate()
		add_child(platform_end)
		platform_end.global_transform = platforms[len(platforms)-1].global_transform
		platform_end.translate(Vector3(0,0,TILE_SIZE) )
		platforms.append(platform_end)
