extends KinematicBody2D

const ACCEL = 50
const MAX_SPEED = 150
const GRAV = 20

onready var vel = Vector2(0, GRAV)

func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	return input

func _physics_process(dt):
	var input = get_input()

	if input.x < 0:
		vel.x = max(vel.x - (ACCEL * dt), -MAX_SPEED)
	elif input.x > 0:
		vel.x = min(vel.x + (ACCEL * dt), MAX_SPEED)
	else:
		vel.x = lerp(vel.x, 0, .01)

	vel = move_and_slide(vel, Vector2(0, -1))
