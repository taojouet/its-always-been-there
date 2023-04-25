extends Node3D

const TILE_SIZE = 20
const PLATEFORM_SCALE = 5

const platform_path = preload("res://Scripts/Plateform.tscn")
const NUM_PLATFORMS = 2
const NB_PLATFORM_TO_END = 0

const PLATFORM_END_PATH = preload("res://Scripts/Plateform_end.tscn")

var count_platform_pass = 0
var platforms = []

var reached_end_platform = false

@onready var player_start_pos = Vector3(0,1,-90)
@onready var slenderman_start_pos = $Slenderman.position
@onready var slender_sound = $Slender_sound

# Called when the node enters the scene tree for the first time.
func _ready():
	create_platforms()	
	$Slenderman.connect("slenderman_catch", death)
	Events.connect("Door",openDoor)
	await get_tree().create_timer(0.5).timeout
	$Player.can_move = true
	$Player.camera_locked = false
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Slenderman.is_active:
		$Slenderman.position.x = lerp($Slenderman.position.x,$Player.position.x,0.05)
	pass

func openDoor():
	await get_tree().create_timer(2.0).timeout
	$Plateform/HomeStart/Idle.position = Vector3(1.25,0.133,4.5)
	$Plateform/HomeStart/Idle.rotation_degrees.y += 180

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
	$Player.can_move = false
	$Player.camera_locked = true
	$Player.rotation_degrees.y = 180
	$Slenderman.position.z -= 6
	$Slenderman/Run/AnimationPlayer.stop(true)
	$Player.slender_camera_catch()
	$Slender_sound.play()
	await get_tree().create_timer(9.0).timeout
	$Player.slender_camera_catch(true)
	await create_tween().tween_property($Player,"position",player_start_pos,1.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished
#	await get_tree().create_timer(0.5).timeout
	erase_platforms()
	$Slenderman.activate(false)
	$Slenderman/Run/AnimationPlayer.play("mixamocom")
	$Slenderman.position = slenderman_start_pos
#	$Player.position = player_start_pos
#	if $Player.rotation_degrees.y<160 or $Player.rotation_degrees.y>200:
#		create_tween().tween_property($Player,"rotation_degrees",Vector3(0,180,0),1.0).set_ease(Tween.EASE_IN)
	create_platforms()
	$Player.can_move = true
	$Player.camera_locked = false


func _on_activate_slenderman_body_entered(body):
	if body is Player:
		$Slenderman.activate(true)
	pass # Replace with function body.

func disableSlenderman():
	$Slenderman.activate(false)

func end_platform_refresh():
	
	if count_platform_pass >= NB_PLATFORM_TO_END:
		reached_end_platform = true
		var platform_end = PLATFORM_END_PATH.instantiate()
		add_child(platform_end)
		platform_end.global_transform = platforms[len(platforms)-1].global_transform
		platform_end.translate(Vector3(0,0,TILE_SIZE) )
		platforms.append(platform_end)
		platform_end.connect("player_end_entered", disableSlenderman)
		platform_end.connect("player_animation_end_entered", end_level)

func end_level():
	$Player.can_move = false
#	$Player.camera_locked = true
	await get_tree().create_timer(10.0).timeout
	await create_tween().tween_property($Player,"position",Vector3(-6,165,0),2.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN).finished
	Events.emit_signal("end_slender")
