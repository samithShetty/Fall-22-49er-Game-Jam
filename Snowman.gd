extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 500
export var acceleration = 3.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("up") - Input.get_action_strength("down")
	apply_impulse(Vector2(0,0),Vector2(acceleration*x,acceleration*-y))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
