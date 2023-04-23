extends Node3D

const tuc_inst = preload("res://Scripts/Tuc_PunchOut.tscn")

const SPAWN_CD = 2.0

var mult = 1.0

var score = 10000
var TUC_SCORE = 100

const RIGHT_INFOS = {"pos":Vector3(150,0,84),"rot":Vector3(0,150,0)}
const LEFT_INFOS = {"pos":Vector3(150,0,-84),"rot":Vector3(0,-150,0)}

var spawn_timer = Timer.new()
var spawn_left = true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(spawn_timer)
	spawn_timer.connect("timeout",spawn)
	spawn_timer.wait_time = SPAWN_CD
	spawn_timer.start()
	
	Events.connect("glass_touched",end_level)
	Events.connect("tuc_killed",score_up)
	Events.connect("player_tucked",score_down)
	pass # Replace with function body.

func update_score():
	$Label.text = "SCORE : "+str(score)

func score_up():
	score += floor(100 * mult)
	update_score()

func score_down():
	score -= floor(100 * 1.5 * mult)
	update_score()

func spawn():
	var tuc = tuc_inst.instantiate()
	if randf()<0.25:
		tuc.be_glass()
	add_child(tuc)
	tuc.SPEED = tuc.SPEED * mult
	tuc.position = LEFT_INFOS.pos if spawn_left else RIGHT_INFOS.pos
	tuc.rotation_degrees = LEFT_INFOS.rot if spawn_left else RIGHT_INFOS.rot
	spawn_left = !spawn_left
	spawn_timer.wait_time = max(0.1,spawn_timer.wait_time*0.98)
	mult *= 1.02
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func end_level():
	print("LOST")
	pass
