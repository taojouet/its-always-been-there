extends Node3D

@onready var base_player_pos = $Player.global_position

# Called when the node enters the scene tree for the first time.
func _ready():
#	await get_tree().create_timer(0.1).timeout
	$Player/Neck/Camera3D.global_rotation_degrees = Vector3(-90,0,0)
	
	Events.connect("tuc_touched_player",restart_dropper)
	pass # Replace with function body.


func restart_dropper():
	
	$Mobs_Holder.destroy_tucs()
	$Player.velocity = Vector3.ZERO
#	$Player/Neck/Camera3D.global_rotation_degrees = Vector3(-90,0,0)
	await create_tween().tween_property($Player,"global_position",base_player_pos,1.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).finished
	$Mobs_Holder.restart_dropper()
#	await get_tree().create_timer(0.25).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
