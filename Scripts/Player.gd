extends CharacterBody3D
class_name Player

@export var SPEED = 5.0
@export var is_lock_Y := false
@export var can_move := true
@export var camera_locked := false
@export var show_punch := false
@export var Level := ""

const JUMP_VELOCITY = 4.5

# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
var lookSensitivity : float = 30

var wait_punch = false
var cpt_punch = 0

@onready var camera = $Neck/Camera3D
@onready var camera_rotation = camera.rotation_degrees

@onready var base_camera_transform = camera.transform

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	if show_punch:
		$Punch.visible = true
		wait_punch = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func _input(event):

var is_punching = false

var mouseDelta = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if show_punch:
		if Input.is_action_just_pressed("LEFT_CLICK"):
			if not is_punching:
				$Punch/punchAnim.play("leftPunch")
				is_punching = true
				$Punch/leftPunch/LeftHit/LeftCollision.disabled = false
				await get_tree().create_timer(0.25).timeout
				is_punching = false
				$Punch/leftPunch/LeftHit/LeftCollision.disabled = true
				cpt_punch += 1
		if Input.is_action_just_pressed("RIGHT_CLICK"):
			if not is_punching:
				$Punch/punchAnim.play("rightPunch")
				is_punching = true
				$Punch/rightPunch/RightHit/RightCollision.disabled = false
				await get_tree().create_timer(0.25).timeout
				is_punching = false
				$Punch/rightPunch/RightHit/RightCollision.disabled = true
				cpt_punch += 1
		if cpt_punch >1 and wait_punch:
			wait_punch = false
			Events.emit_signal("two_punch")

func _process(delta):
	if not camera_locked:
		if !is_lock_Y: 
			# rotate the camera along the x axis
			camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
			# clamp camera x rotation axis
			camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
		
		# rotate the player along their y-axis
		rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
		
		# reset the mouseDelta vector
		mouseDelta = Vector2.ZERO

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if can_move:
		pass
		move_and_slide()

func slender_camera_catch(reverse=false):
	if reverse:
		$Punch/punchAnim.play_backwards("SlenderCatch")
	else:
		$Punch/punchAnim.play("SlenderCatch")
	
func hit_tuc(body):
	if body is Tuc_PunchOut:
		body.kill()
	pass # Replace with function body.
