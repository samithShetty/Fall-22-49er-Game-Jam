extends Line2D

export var length = 500
export var delay = 50
var point_queue = []
var point = Vector2()

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = get_parent().global_position
	point_queue.append(point)
	
	add_point(point_queue.pop_front())
	
	while get_point_count() > length:
		remove_point(0)
