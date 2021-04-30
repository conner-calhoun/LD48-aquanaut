extends Node2D

export(NodePath) var player_path
export(NodePath) var ui_path
export(NodePath) var main_mod
export(NodePath) var parallax_path

export(PackedScene) var glow_coral

onready var player = get_node(player_path)
onready var ui = get_node(ui_path)
onready var depth_ui = ui.get_node("Depth")

# TODO: Flares will be an icon with a number beside it
const flare_str = "  x%s"
onready var flares = ui.get_node("Flares")

onready var canv_mod = get_node(main_mod)
onready var parallax = get_node(parallax_path)
onready var parallax_mod = parallax.get_node("ParallaxBackground/CanvasModulate")

const dark_speed = .02
onready var dark = 0.0

onready var player_flares = player.get_flare_count()

onready var depth = 0.0
onready var depth_m = 0.0

const GlowCoralPlacement = {
	Left = 5,
	Right = 123
}

onready var coral_time = 10
onready var last_placed_coral = coral_time + 1
func handle_coral(delta: float):
	last_placed_coral += delta
	
	# coral becomes more common the further down you go
	if depth_m < 50:
		coral_time = 10
	elif depth_m < 100:
		coral_time = 7
	else:
		coral_time = 3
	
	# place a random coral occasionally
	var r = randi()%3
	if r == 0 and last_placed_coral > coral_time:
		var gc = glow_coral.instance()
		gc.position = Vector2(GlowCoralPlacement.Left, depth + 140)
		add_child(gc)
		last_placed_coral = 0
	if r == 1 and last_placed_coral > coral_time:
		var gc = glow_coral.instance()
		gc.position = Vector2(GlowCoralPlacement.Right, depth + 140)
		add_child(gc)
		last_placed_coral = 0

func update_flare_count():
	player_flares = player.get_flare_count()
	flares.text = flare_str % player_flares

func _ready():
	randomize()
	player.connect("flare_used", self, "update_flare_count")
	flares.text = flare_str % player_flares

func _physics_process(delta):
	depth = player.position.y - 64
	depth_m = depth / 8
	depth_ui.text = "DEPTH: %s" % round(depth_m)
	
	dark += dark_speed * delta
	
	var ocean_blue = Color("#ebfeff").darkened(dark)
	canv_mod.color = ocean_blue
	parallax_mod.color = ocean_blue

	handle_coral(delta)
	
	# on player death, load final scene with depth
	
func get_depth() -> float:
	return round(depth_m)
