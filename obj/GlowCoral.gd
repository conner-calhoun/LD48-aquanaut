extends Sprite

onready var light = $Light2D
onready var time = 0

const oscillation = .5
const grow = 1.2

func _physics_process(delta):
	# handle oscillation
	time += delta
	light.texture_scale = 1.2 + abs((sin(time*oscillation) * grow))
