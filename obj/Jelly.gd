extends KinematicBody2D

const oscillation = .5
onready var time = 0
onready var vel = Vector2.ZERO

func handle_anim_fin():
	match $AnimatedSprite.animation:
		"hit":
			$AnimatedSprite.play("default")

func handle_body_entered(body):
	match body.get_name():
		"Player":
			# Kill player, play animation
			$AnimatedSprite.play("hit")

func _ready():
	$AnimatedSprite.connect("animation_finished", self, "handle_anim_fin")
	$Area2D.connect("body_entered", self, "handle_body_entered")
	
	# after 8 secs, delete it
	yield(get_tree().create_timer(8), "timeout")
	queue_free()

func _physics_process(delta):
	time += delta
	
	vel.x = cos(time * 1) * 3
	vel.y = sin(time * 5) * 20
	
	vel = move_and_slide(vel)
