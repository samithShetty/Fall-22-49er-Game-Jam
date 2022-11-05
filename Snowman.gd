extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 500
export var acceleration = 3.0
var lookDir = Vector2(0,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("up") - Input.get_action_strength("down")
	apply_impulse(Vector2(0,0), Vector2(acceleration*x,acceleration*-y))
	
	lookDir = lerp(lookDir, Vector2(x,-y), .07)
	look_at(lookDir + position)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var isInWater = space_state.intersect_ray(Vector2(0,0), get_linear_velocity().rotated(-get_global_rotation()).normalized()*35, [], 7, true, true)
	if isInWater:
		print("You fell in water!")
	update()

func _draw():
	draw_line(get_linear_velocity().rotated(-get_global_rotation()).normalized()*30, get_linear_velocity().rotated(-get_global_rotation()).normalized()*35,Color(0,0,0),3,false)
	
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		print()
