extends Node3D

signal finish_Title
signal start_game

var can_start = false
var is_starting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("spawn_title")
	await $AnimationPlayer.animation_finished
	$Text/MeshInstance3D2.visible =true
	$AnimationPlayer.play("press_space")
	await get_tree().create_timer(0.1).timeout
	can_start = true
	emit_signal("finish_Title")
	


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		if !can_start:
			await finish_Title
		start()

func start():
	if !is_starting:
		is_starting = true
		$Text/MeshInstance3D2.visible = false
#		$Text/Dream_icon.visible = false
		$AnimationPlayer.play("fade_title")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("Start")
		await $AnimationPlayer.animation_finished
		emit_signal("start_game")
