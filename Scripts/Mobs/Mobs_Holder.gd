extends Node3D

@onready var mob_inst = preload("res://Scripts/Mobs/Mob.tscn")

const NB_TUCS = 1500
const BATCH_CD = 0.25

var x_range = Vector2(-25,25)
var y_range = Vector2(20,142)
var z_range = Vector2(-25,25)
var y_rota = Vector2(0, 180)
var x_rota = Vector2(-15, 15)

var nb_batch = 150
var spawned = 0

@onready var batch_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(batch_timer)
	batch_timer.connect("timeout",do_batch)
	batch_timer.one_shot = false
	batch_timer.wait_time = BATCH_CD

func destroy_tucs():
	for tuc in get_children():
		if tuc is Dropper_Tuc:
			tuc.queue_free()
	

func restart_dropper():
	spawned = 0
	do_batch()
	batch_timer.start()
	pass

func do_batch():
	for i in range(nb_batch):
		Spawn_mobs()
		spawned += 1
	if spawned>=NB_TUCS:
		batch_timer.stop()
		

func Spawn_mobs():
	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y = randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	var random_z = randi() % int(z_range[1]-z_range[0]) + 1 + z_range[0]
	var random_y_rotation = randi() % int(y_rota[1]-y_rota[0]) + 1 + y_rota[0]
	var random_x_rotation = randi() % int(x_rota[1]-x_rota[0]) + 1 + x_rota[0]
	
	var m = mob_inst.instantiate()
	add_child(m)
	m.position = Vector3(random_x, random_y ,random_z)
	m.rotation_degrees = Vector3(random_x_rotation, random_y_rotation, 0)
	var scale_rate = randi_range(1.0,2.0)
	create_tween().tween_property(m,"scale",Vector3.ONE*scale_rate,1.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

	
#   var random_pos = Vector2(random_x, random_y)

#	var m = mob_inst.instantiate()
#	add_child(m)
#	m.position = Vector3(10,10,10)
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
