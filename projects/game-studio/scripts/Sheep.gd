extends CharacterBody3D

## Ticket #1 sheep behavior: wander to a random point near home, pause to
## "graze" (dip the head) for a bit, then pick a new point and repeat.
## Each sheep randomizes its own timing so the flock doesn't move in lockstep.

@export var wander_radius: float = 3.0
@export var walk_speed: float = 1.2
@export var min_graze_time: float = 2.5
@export var max_graze_time: float = 5.5
@export var turn_speed: float = 4.0

enum State { GRAZING, WALKING }

var state: State = State.GRAZING
var home_position: Vector3
var target_position: Vector3
var state_timer: float = 0.0
var graze_tween: Tween

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head: Node3D = $Head


func _ready() -> void:
	home_position = global_position
	randomize_and_start_graze()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	state_timer -= delta

	match state:
		State.GRAZING:
			velocity.x = 0.0
			velocity.z = 0.0
			if state_timer <= 0.0:
				pick_new_target()
		State.WALKING:
			var to_target: Vector3 = target_position - global_position
			to_target.y = 0.0
			if to_target.length() < 0.25:
				randomize_and_start_graze()
			else:
				var dir: Vector3 = to_target.normalized()
				velocity.x = dir.x * walk_speed
				velocity.z = dir.z * walk_speed
				# Gently turn to face the direction we're walking instead of
				# snapping instantly, so turns look natural.
				var target_angle: float = atan2(dir.x, dir.z) + PI
				rotation.y = lerp_angle(rotation.y, target_angle, turn_speed * delta)

	move_and_slide()


func pick_new_target() -> void:
	if graze_tween:
		graze_tween.kill()
	head.rotation.x = 0.0

	var angle := randf() * TAU
	var dist := randf() * wander_radius
	target_position = home_position + Vector3(cos(angle) * dist, 0.0, sin(angle) * dist)
	state = State.WALKING


func randomize_and_start_graze() -> void:
	state = State.GRAZING
	state_timer = randf_range(min_graze_time, max_graze_time)
	play_graze_animation()


func play_graze_animation() -> void:
	if graze_tween:
		graze_tween.kill()
	graze_tween = create_tween()
	graze_tween.set_loops()
	# Lower the head to "graze" on the grass, hold it, then lift back up.
	graze_tween.tween_property(head, "rotation:x", deg_to_rad(-32.0), 0.7).set_trans(Tween.TRANS_SINE)
	graze_tween.tween_interval(randf_range(0.6, 1.4))
	graze_tween.tween_property(head, "rotation:x", 0.0, 0.7).set_trans(Tween.TRANS_SINE)
	graze_tween.tween_interval(randf_range(0.4, 1.1))
