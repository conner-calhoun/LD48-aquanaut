extends Node2D

onready var prev_depth = 0
onready var depth = 0

export(NodePath) var player_path
export(PackedScene) var jelly_scn

onready var player: KinematicBody2D = get_node(player_path)
onready var spawn_depth = 7
onready var spawn_depth_diff = 7

func _physics_process(delta):
	prev_depth = depth
	depth = get_parent().get_depth()
	
	# Spawn more jellys the lower you go
	if spawn_depth > spawn_depth_diff:
		var jelly = jelly_scn.instance()
		
		jelly.position.x = randi() % 108 + 10 # Range [10, 118]
		jelly.position.y = player.position.y + 90
		get_tree().get_root().add_child(jelly)
		
		spawn_depth = 0
		spawn_depth_diff = randi() % 4 + 5
		
	spawn_depth += depth - prev_depth
