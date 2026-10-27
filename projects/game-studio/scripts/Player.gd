extends CharacterBody3D

## Ticket #1 player controller: WASD/arrow movement relative to where the
## camera is facing, mouse-look for an over-the-shoulder camera, and gravity.

@export var move_speed: float = 4.5
@export var mouse_sensitivity: float = 0.0025
@export var min_pitch_deg: float = -55.0
@export var max_pitch_deg: float = 25.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Tracks the "visual" pitch (negative = looking down, positive = looking up),
# independent of how it's actually applied to the camera node below. Kept as
# its own variable instead of reading rotation back off a node because the
# node we rotate (camera_pitch) sits inside a part of the rig that's already
# flipped 180 degrees on Y, which would otherwise make the sign confusing.
var pitch: float = 0.0

# CameraPivot and SpringArm3D stay level now (yaw-only) so the boom never
# swings the camera's position down into the ground when looking down.
# Pitch instead rotates CameraPitch, a small node at the END of the spring
# arm, right before the Camera3D. Rotating here only changes which way the
# camera faces, not where it sits, because CameraPitch's own position isn't
# moving -- only its rotation changes.
@onready var camera_pitch: Node3D = $CameraPivot/SpringArm3D/CameraPitch


func _ready() -> void:
	# Capture the mouse so moving it looks around instead of hitting the
	# edge of the game window.
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Yaw: turning the whole player left/right also turns the camera,
		# since the camera rig is a child of the player.
		rotate_y(-event.relative.x * mouse_sensitivity)

		# Pitch: update our own tracked angle (not the arm, not the pivot),
		# clamped so the player can never flip the camera upside down or look
		# straight into the ground. Moving the mouse up should look up, so a
		# smaller event.relative.y (mouse moved up = negative) increases pitch.
		pitch = clamp(
			pitch - event.relative.y * mouse_sensitivity,
			deg_to_rad(min_pitch_deg),
			deg_to_rad(max_pitch_deg)
		)
		# CameraPitch lives inside the part of the rig that's rotated 180
		# degrees on Y (so the camera faces forward instead of backward),
		# which flips the sign of what "rotate up" means locally -- so we
		# apply the negative of our tracked pitch here to cancel that flip
		# out and keep "pitch positive = look up" true from the player's
		# point of view.
		camera_pitch.rotation.x = -pitch
	elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		# Let the player get their mouse cursor back if they need it.
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.pressed:
		# Clicking back into the game window re-captures the mouse.
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	var input_dir := Vector2.ZERO
	if Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
	if Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	input_dir = input_dir.normalized()

	# Movement is relative to the player's own facing, and the player turns
	# with the mouse (yaw), so "forward" always matches where the camera
	# is looking.
	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	if direction.length() > 0.01:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, move_speed)
		velocity.z = move_toward(velocity.z, 0.0, move_speed)

	move_and_slide()
