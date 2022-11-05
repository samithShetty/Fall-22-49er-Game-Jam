extends RigidBody2D

export var speed = 500
export var acceleration = 3.0
var lookDir = Vector2(0,1)


func _physics_process(delta):
	linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("up") - Input.get_action_strength("down")
	apply_impulse(Vector2(0,0), Vector2(acceleration*x,acceleration*-y))
	
	if x != 0 or y != 0:
		lookDir = lerp(lookDir, Vector2(x,-y), .07)
		look_at(lookDir + position)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var waterCollision = space_state.intersect_ray(position, position + get_linear_velocity().rotated(-get_global_rotation()).normalized()*30, [self], 7, true, true)


func _on_WaterArea_area_entered(area):
	print("DEATH")
