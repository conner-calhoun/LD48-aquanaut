extends Sprite

onready var light = $Light2D
onready var time = 0

func _physics_process(delta):
	# handle oscillation
	time += delta
	light.texture_scale = 1.2 + abs((sin(time*1.1) * 1))
