extends RigidBody2D

export var turn_speed = 0.05
export var speed = 500
export var max_speed = 500
export var acceleration = 3.0
export var drift_speed =  0.05

var lookDir = Vector2(1,0)
var moveAngle = 0


func _physics_process(delta):
	
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("up") - Input.get_action_strength("down")
	
	if x: # Extra turn render rotation
		moveAngle += sign(x) * turn_speed
		lookDir = lookDir.slerp(Vector2(1,0).rotated(moveAngle + sign(x)*PI/2),0.1)
	else: # Normal Smooth render rotation
		lookDir = lookDir.slerp(Vector2(1,0).rotated(moveAngle),0.1)
		
	linear_velocity = Vector2(speed,0).rotated(moveAngle)
	rotation = lookDir.angle()
	
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var waterCollision = space_state.intersect_ray(position, position + get_linear_velocity().rotated(-get_global_rotation()).normalized()*30, [self], 7, true, true)


func _on_WaterArea_area_entered(area):
	print("DEATH")
