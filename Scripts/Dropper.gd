extends Node3D

@onready var base_player_pos = $Player.position

var is_started = false
var win = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Player/Neck/Camera3D.global_rotation_degrees = Vector3(-90,0,0)
	
	Events.connect("tuc_touched_player",restart_dropper)
	Events.connect("player_touched_ground",next_scene)
	$Timer.connect("timeout",lookatIce)
	await get_tree().create_timer(0.5).timeout
	$Player.can_move = true
	$Player.camera_locked = false
	pass # Replace with function body.


func restart_dropper():
	
	$Mobs_Holder.destroy_tucs()
	$Player.velocity = Vector3.ZERO
#	$Player/Neck/Camera3D.global_rotation_degrees = Vector3(-90,0,0)
	await create_tween().tween_property($Player,"global_position",base_player_pos,1.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).finished
	$Mobs_Holder.restart_dropper()
#	await get_tree().create_timer(0.25).timeout

func next_scene():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if win:
		$Player/Neck/Camera3D.look_at($Map/Floor/Water/Icecube1Mesh.position)
	pass

func lookatIce():
	$Player/basicCharacter2.visible=false
	$Player/Neck/Camera3D.look_at($Map/Floor/Water/Icecube1Mesh.position)
	await get_tree().create_timer(0.25).timeout
	$Player/Neck/Camera3D.look_at($Map/Floor/Water/Icecube1Mesh.position)

func _on_win_trigger_body_entered(body):
	if !win and body is Player and body.Level == "Dropper":
		win = true
		$Player.camera_locked = true
		$Player.can_move = false
		$Mobs_Holder.destroy_tucs()
		$Map/Floor/FloorCollision.disabled = true
		$Map/InvisibleWalls/MeshInstance3D/StaticBody3D/Cup_Collision.disabled = true
#		$Timer.start()
		lookatIce()
		await create_tween().tween_property($Player,"position",Vector3(-100,42.0,2.0),2.0).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN).finished
		Events.emit_signal("end_dropper")
	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	if !is_started and body is Player and body.Level == "Dropper":
		is_started = true
		base_player_pos = $Player.global_position
		$HomeStart/Home.dissolve()
		$Player.can_move = false
		await get_tree().create_timer(1.5).timeout
		$Player.can_move = true
		$Mobs_Holder.restart_dropper()
		$Map.visible = true
		$Player.is_lock_Y = true
		await create_tween().tween_property($Player/Neck/Camera3D,"rotation_degrees:x",-90,0.42).finished
		$HomeStart.queue_free()
	pass # Replace with function body.
