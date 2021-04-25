extends Node2D

export(NodePath) var player_path
export(NodePath) var ui_path
export(NodePath) var main_mod
export(NodePath) var parallax_path

onready var player = get_node(player_path)
onready var ui = get_node(ui_path)
onready var depth = ui.get_node("Depth")

# TODO: Flares will be an icon with a number beside it
const flare_str = "  x%s"
onready var flares = ui.get_node("Flares")

onready var canv_mod = get_node(main_mod)
onready var parallax = get_node(parallax_path)
onready var parallax_mod = parallax.get_node("ParallaxBackground/CanvasModulate")

const dark_speed = .02
onready var dark = 0.0

onready var player_flares = player.get_flare_count()

func update_flare_count():
	player_flares = player.get_flare_count()
	flares.text = flare_str % player_flares

func _ready():
	player.connect("flare_used", self, "update_flare_count")
	flares.text = flare_str % player_flares

func _physics_process(delta):
	var dep = player.position.y - 64
	dep = dep / 4
	depth.text = "DEPTH: %s" % round(dep)
	
	# TODO: a cute way of doing this
	dark += dark_speed * delta
	
	var ocean_blue = Color("#6e67e6").darkened(dark)
	canv_mod.color = ocean_blue
	parallax_mod.color = ocean_blue
