extends Node2D

const SEGS = 12
const SEG_LEN = 6
const CONSTRS = 50
const GRAVITY = Vector2(0, -50)

export(PackedScene) var segment
export(NodePath) var player_path

onready var player = get_node(player_path)

var head = null
var segments = []

class Segment:
	var obj
	var old_pos

func _ready():
	var y_placement = -12
	for x in range(SEGS):
		var object = segment.instance()
		add_child(object)
		object.position = Vector2(0, y_placement)
		
		var seg = Segment.new()
		seg.obj = object
		seg.old_pos = Vector2(0, y_placement)
		segments.append(seg)
		y_placement -= SEG_LEN
		
	head = segments[0]
	
func _physics_process(delta):
	for seg in segments:
		var velocity = seg.obj.position - seg.old_pos
		seg.old_pos = seg.obj.position
		velocity += GRAVITY * delta
		velocity.x -= player.vel.x / 6 * delta
		seg.obj.position += velocity
		
	for x in range(CONSTRS):
		apply_constraints()
		
func apply_constraints():
	head.obj.position = Vector2(0, -12)

	for x in range(len(segments) - 1):
		var curr = segments[x]
		var next = segments[x+1]
		
		var dist = curr.obj.position.distance_to(next.obj.position)
		var err = dist - SEG_LEN
		
		var change_dir = (curr.obj.position - next.obj.position).normalized();
		var change_amt = change_dir * err
		
		if x != 0:
			curr.obj.position -= change_amt * .5
			next.obj.position += change_amt * .5
		else:
			next.obj.position += change_amt * .5
