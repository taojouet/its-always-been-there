extends Node3D
class_name Slenderman

signal slenderman_catch

var speed = 14

enum {
	IDLE,
	RUN,
	DRINK
}

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	play(RUN)

func activate(active):
	is_active = active
	visible = active

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		translate(Vector3(0, 0, speed * delta))

func hide_anim():
	for a in get_children():
		a.visible = false

func play(anim):
	hide_anim()
	match(anim):
		RUN:
			$Run.visible = true


func _on_area_3d_body_entered(body):
	if body is Player and is_active:
		is_active = false
		emit_signal("slenderman_catch")
#		print("player_entered")
	pass # Replace with function body.
