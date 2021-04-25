extends KinematicBody2D

onready var light = get_node("Sprite/Light2D")
onready var time = 0

onready var follow_player = true
var player = KinematicBody2D.new()

var velocity = Vector2.ZERO

onready var hang_time = 2

func init(pos: Vector2, vel: Vector2, player_node: KinematicBody2D):
	position = pos
	velocity = vel
	velocity.y += 15
	player = player_node

func _physics_process(delta):
	# handle oscillation
	time += delta
	light.texture_scale = .8 + abs((sin(time*1.1) * .5))
	
	velocity.x = lerp(velocity.x, 0, .01)
	
	if time > hang_time:
		velocity.y = lerp(velocity.y, 0, .05)
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
