extends Node2D

export(NodePath) var player_path

onready var player = get_node(player_path)

func _physics_process(dt):
	position.y = player.position.y - 64
