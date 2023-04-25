extends Node3D
class_name Tuc_PunchOut

var SPEED = 20.0
var MAX_SPEED = 42

const LEFT_DIR = Vector3(-0.868243,0,0.496139)
const RIGHT_DIR = Vector3(0.868243,0,0.496139)

var is_left = false

var is_glass = false

var is_active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func be_glass():
	$GlassStl.visible = true
	$MeshInstance3D.visible = false
	is_glass = true
	$CollisionShape3D.position.x += 0.66

func kill():
	is_active = false
	if is_glass:
		is_active = false
		await create_tween().tween_property($GlassStl.get_surface_override_material(0),"grow_amount",0.1,1.0).finished
		Events.emit_signal("glass_touched")
		
	else:
		Events.emit_signal("tuc_killed")
		create_tween().tween_property(self,"global_position:x",global_position.x+10,0.20).set_trans(Tween.TRANS_EXPO)
		await create_tween().tween_property(self,"rotation_degrees:z",85,0.25).set_trans(Tween.TRANS_EXPO)
		await get_tree().create_timer(0.15).timeout
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		translate_object_local(min(MAX_SPEED,SPEED)*delta* Vector3(1.0, 0.0, 0.0))
	pass


func _on_body_entered(body):
	if body is Player:
		if is_glass:
			is_active = false
			$GlassStl.drink(0.15)
			await get_tree().create_timer(0.25).timeout	
			Events.emit_signal("tuc_killed")
		else:
			Events.emit_signal("player_tucked")
		queue_free()
	pass # Replace with function body.
