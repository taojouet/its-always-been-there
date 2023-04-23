extends Node3D
class_name Tuc_PunchOut

const SPEED = 20.0

const LEFT_DIR = Vector3(-0.868243,0,0.496139)
const RIGHT_DIR = Vector3(0.868243,0,0.496139)

var is_left = false

var is_glass = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func be_glass():
	$GlassStl.visible = true
	$MeshInstance3D.visible = false
	is_glass = true

func kill():
	if is_glass:
		Events.emit_signal("glass_touched")
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate_object_local(SPEED*delta* Vector3(1.0, 0.0, 0.0))
	pass
