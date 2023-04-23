extends Node3D
class_name Slenderman

signal slenderman_catch

var speed = 6.0

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
		IDLE:
			$Idle.visible = true
		RUN:
			$Run.visible = true
		DRINK:
			$Drink.visible = true


func _on_area_3d_body_entered(body):
	if body is Player and is_active:
		emit_signal("slenderman_catch")
		print("CATCH")
	pass # Replace with function body.
