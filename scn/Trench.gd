extends Node2D

export(NodePath) var player_path
export(NodePath) var ui_path
export(NodePath) var main_mod
export(NodePath) var parallax_path

onready var player = get_node(player_path)
onready var ui = get_node(ui_path)
onready var depth = ui.get_node("Depth")
onready var canv_mod = get_node(main_mod)
onready var parallax = get_node(parallax_path)
onready var parallax_mod = parallax.get_node("ParallaxBackground/CanvasModulate")

const dark_speed = .02
var dark = 0.0

func _physics_process(delta):
	var dep = player.position.y - 64
	dep = dep / 4
	depth.text = "DEPTH: %s" % round(dep)
	
	# TODO: a cute way of doing this
	dark += dark_speed * delta
	
	var ocean_blue = Color("#6e67e6").darkened(dark)
	canv_mod.color = ocean_blue
	parallax_mod.color = ocean_blue
