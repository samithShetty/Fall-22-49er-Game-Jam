extends Line2D

export var length = 500
export var delay = 50
onready var player = get_parent().get_node("Snowman")
onready var area = $WaterArea
var point = Vector2()
var prev_point = Vector2()
var segments = []

func _ready():
	global_position = Vector2(0,0)
	global_rotation = 0
	prev_point = player.global_position
	add_point(prev_point)
	
	
func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = player.global_position
	add_point(point)
	
	#Add segment collider
	var new_segment = CollisionShape2D.new()
	new_segment.shape = SegmentShape2D.new()
	new_segment.shape.a = prev_point
	new_segment.shape.b = point
	area.add_child(new_segment)
	segments.append(new_segment)
	
	prev_point = point

	while get_point_count() > length:
		remove_point(0)
		area.remove_child(segments.pop_front())
