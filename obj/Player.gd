extends KinematicBody2D

export(PackedScene) var flare_scn

const ACCEL = 50
const MAX_SPEED = 150
onready var grav = 20

onready var vel = Vector2(0, grav)
onready var flares = 2

signal flare_used

func get_flare_count() -> int:
	return flares

func use_flare():
	flares -= 1
	emit_signal("flare_used")
	var flare = flare_scn.instance()
	flare.init(position, vel, self)
	get_tree().get_root().add_child(flare)

func get_input_axis() -> Vector2 :
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	return input

func _physics_process(dt):
	# handle flares
	if Input.is_action_just_pressed("action") and flares > 0:
		use_flare()
	
	if Input.is_action_pressed("boost"):
		grav = lerp(grav, 50, .2)
	else:
		grav = lerp(grav, 20, .01)
	vel.y = grav
	
	# handle movement
	var axis = get_input_axis()

	if axis.x < 0:
		vel.x = max(vel.x - (ACCEL * dt), -MAX_SPEED)
	elif axis.x > 0:
		vel.x = min(vel.x + (ACCEL * dt), MAX_SPEED)
	else:
		vel.x = lerp(vel.x, 0, .01)

	vel = move_and_slide(vel, Vector2(0, -1))
