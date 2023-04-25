extends MeshInstance3D


var did_drink = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func drink(duration):
	if !did_drink:
		did_drink = true
		await create_tween().tween_property($Node3D,"scale:z",0.0,duration).finished
		$Node3D.visible = false
