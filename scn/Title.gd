extends Node2D

onready var cam = $Camera2D
onready var canv: CanvasModulate = get_node("ParallaxBG/ParallaxBackground/CanvasModulate")
onready var title: RichTextLabel = get_node("Camera2D/Control/Title")
onready var begin: RichTextLabel = get_node("Camera2D/Control/Begin")
onready var controls: RichTextLabel = get_node("Camera2D/Control/Controls")

var darken = false
var dark_val = .5
onready var ocean_blue = Color("#ebfeff").darkened(.5)

func _ready():
	canv.color = ocean_blue

func _physics_process(delta: float):
	cam.position.y += 20 * delta
	
	if Input.is_action_just_pressed("action"):
		title.bbcode_text = "[center]GOOD LUCK![/center]"
		begin.text = ""
		controls.text = ""
		darken = true
		
		yield(get_tree().create_timer(3), "timeout")
		canv.color = ocean_blue.darkened(0.0)
		get_tree().change_scene("res://scn/TheTrench.tscn")

	if darken:
		canv.color = ocean_blue.darkened(dark_val)
		dark_val += delta * .2
