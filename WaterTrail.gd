extends Line2D

export var length = 500
export var head_buffer = 32
export var tail_buffer = 0
onready var player = get_parent().get_node("Snowman")
onready var area = $WaterArea
onready var freezeTimer = 5

var active = true
var point = Vector2()
var prev_point = Vector2()
var segments = []

func _ready():
	global_position = Vector2(0,0)
	global_rotation = 0
	prev_point = player.global_position
	add_point(prev_point)
	
	
func _process(delta):
	if player.isJumping:
		active = false
	if not active:
		if get_point_count() == 0:
			queue_free()
		elif freezeTimer <=0:
			remove_point(0)
			area.remove_child(segments.pop_front())
		else:
			freezeTimer -= delta
	else:
		point = player.global_position - player.linear_velocity.normalized()*head_buffer
		add_point(point)
		
		#Add segment collider
		if (get_point_count() > tail_buffer):
			var new_segment = CollisionShape2D.new()
			new_segment.shape = SegmentShape2D.new()
			new_segment.shape.a = prev_point
			new_segment.shape.b = point
			area.add_child(new_segment)
			segments.append(new_segment)
			prev_point = point
	
	# Collision Check
	
	for p in points:
		if (p-player.position).length() < 5 and (not player.isJumping) and p != player.position:
			print("death")

		
	while get_point_count() > length:
		remove_point(0)
		area.remove_child(segments.pop_front())
	

