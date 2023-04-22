extends Node3D
class_name Slenderman


enum {
	IDLE,
	RUN,
	DRINK
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	play(IDLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
			
