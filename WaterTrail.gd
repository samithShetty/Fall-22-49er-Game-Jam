extends Line2D


var length = 500
var point = Vector2(0,0)

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = get_parent().global_position
	
	add_point(point)
	
	while get_point_count() > length:
		remove_point(0)
