extends Sprite

onready var light = $Light2D
onready var time = 0

const oscillation = .5
const grow = 1.1

func _physics_process(delta):
	# handle oscillation
	time += delta
	light.texture_scale = .5 + abs((sin(time*oscillation) * grow))
