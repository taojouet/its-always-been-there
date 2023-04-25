extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("two_punch",start_game)
	pass # Replace with function body.


func start_game():
	$HomeStart/Home.dissolve()
	create_tween().tween_property($platform/Ring,"transparency",0.0,1.0)
	await $HomeStart/Home.end_dissolve
	$Player.camera_locked = false
	$tuc_spawner/Label.visible = true
	$HomeStart.queue_free()
	$tuc_spawner.start_fight()
