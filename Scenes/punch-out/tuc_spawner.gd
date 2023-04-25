extends Node3D

const tuc_inst = preload("res://Scripts/Tuc_PunchOut.tscn")

const SPAWN_CD = 2.0

var mult = 1.0

var score = 500
var TUC_SCORE = 150
var MAX_SCORE = 10000

const RIGHT_INFOS = {"pos":Vector3(150,0,84),"rot":Vector3(0,150,0)}
const LEFT_INFOS = {"pos":Vector3(150,0,-84),"rot":Vector3(0,-150,0)}

var spawn_timer = Timer.new()
var spawn_left = true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(spawn_timer)
	spawn_timer.connect("timeout",spawn)
	spawn_timer.wait_time = SPAWN_CD
	
	Events.connect("glass_touched",lose)
	Events.connect("tuc_killed",score_up)
	Events.connect("player_tucked",score_down)
	pass # Replace with function body.

func start_fight():
	spawn_timer.start()

func update_score():
	$Label.text = "SCORE : "+str(score) + "/" + str(MAX_SCORE)

func score_up():
	score += floor(TUC_SCORE * mult)
	update_score()
	if score >= MAX_SCORE:
		end_level()

func score_down():
	score -= floor(TUC_SCORE * 2.5 * mult)
	update_score()
	if score <= 0:
		lose()

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
	mult *= 1.025

	pass

func kill_all():
	for tuc in get_children():
		if tuc is Tuc_PunchOut:
			tuc.depop()

func lose():
	mult = 1.0
	spawn_timer.wait_time = SPAWN_CD
	spawn_timer.stop()
	kill_all()
	await get_tree().create_timer(2.0).timeout
	score = 500
	update_score()
	start_fight()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func end_level():
	spawn_timer.stop()
	Events.emit_signal("end_punch_out")
	pass
