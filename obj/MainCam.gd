extends Node2D

export(NodePath) var player_path
export(NodePath) var hp_ui_path

export(PackedScene) var heart_scn

onready var player = get_node(player_path)
onready var hp_ui = get_node(hp_ui_path)

onready var heart_count = 2
onready var heart_offset = 12

func _physics_process(dt: float):
	var player_hp = player.get_hp()
	if heart_count != player_hp:
		heart_count = player_hp
		for heart in hp_ui.get_children():
			heart.queue_free()
		var offset = 0
		for i in range(heart_count):
			var heart = heart_scn.instance()
			heart.offset.x += offset
			offset += heart_offset
			hp_ui.add_child(heart)
	
	position.y = player.position.y - 64
