extends Node3D

signal player_entered

const forests = [
	preload("res://Scenes/Forest/Forest1.tscn"),
	preload("res://Scenes/Forest/Forest2.tscn"),
	preload("res://Scenes/Forest/Forest3.tscn"),
	preload("res://Scenes/Forest/Forest4.tscn"),
]

var can_trigger = true

# Called when the node enters the scene tree for the first time.
func _ready():
	rand_forest()
	pass # Replace with function body.


func rand_forest():
	var r = randi()%4
	for f in $ForestHolder.get_children():
		f.queue_free()
	var frst = forests[r].instantiate()
	$ForestHolder.add_child(frst)
	can_trigger = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getPlayerdetection():
	return $Playerdetection


func _on_playerdetection_body_entered(body):
	if body is Player and can_trigger:
		can_trigger = false
		emit_signal("player_entered")
	pass # Replace with function body.
