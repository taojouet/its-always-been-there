extends Node3D

const slender_map = preload("res://Scenes/Runner.tscn")
const dropper_map = preload("res://Scripts/Dropper.tscn")
const punchout_map = preload("res://Scenes/punch-out/punch-out.tscn")
const endgame_map = preload("res://Scenes/EndGame/EndGame.tscn")

var curr_map

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$GameStart.connect("start_game",spawn_slender)
	Events.connect("end_slender",spawn_dropper)
	Events.connect("end_dropper",spawn_punchout)
	Events.connect("end_punch_out",spawn_endgame)
	pass # Replace with function body.


func spawn_slender():
	curr_map = slender_map.instantiate()
	add_child(curr_map)
	$GameStart.queue_free()
	pass

func spawn_dropper():
	var pred_map = curr_map
	curr_map = dropper_map.instantiate()
	add_child(curr_map)
	pred_map.queue_free()
	pass

func spawn_punchout():
	var pred_map = curr_map
	curr_map = punchout_map.instantiate()
	add_child(curr_map)
	pred_map.queue_free()
	pass

func spawn_endgame():
	var pred_map = curr_map
	curr_map = endgame_map.instantiate()
	add_child(curr_map)
	pred_map.queue_free()
	pass
