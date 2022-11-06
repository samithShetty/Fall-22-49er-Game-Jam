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
	#linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	
	var direction = (get_parent().get_node("Snowman").position - position)
	
	
	
	direction = direction.normalized()
	
	var x = direction.x
	var y = direction.y
	
	apply_impulse(Vector2(0,0),Vector2(acceleration*x,acceleration*y))
	
	look_at(direction + position)
	if position.length() > 2500:
		Score.call("addToScore", 10)
		get_parent().get_node("Snowman/taco").play()
		queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	body.moveAngle = (body.position-position).normalized().angle()
