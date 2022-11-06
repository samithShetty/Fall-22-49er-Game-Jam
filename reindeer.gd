extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 200
export var acceleration = 3.0
var maxSpd = 0
var rudolph = preload("res://Ruldolph.svg")
var cooldown = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if rng.randi_range(1,10) == 10:
		speed = 500
		maxSpd = speed
		$sprite.texture = rudolph

func _physics_process(delta):
	#linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	
	var direction = (get_parent().get_node("Snowman").position - position)
	
	if cooldown > 0:
		cooldown -= delta
	
	direction = direction.normalized()
	
	var x = direction.x
	var y = direction.y
	
	if (get_parent().get_node("Snowman").position - position).length() <= 300 and cooldown <= 0:
		speed = 800 + maxSpd
		acceleration = 4.0
		linear_velocity =  (get_parent().get_node("Snowman").position - position).normalized() * (500 + maxSpd)
		cooldown = 3
	else:
		speed = maxSpd
		acceleration = 3.0
	
	
	apply_impulse(Vector2(0,0),Vector2(acceleration*x,acceleration*y))
	
	
	look_at(direction + position)
	if position.length() > 2500:
		
		Score.call("addToScore", 30)
		queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MeleeArea_body_entered(body):
	body.moveAngle = (body.position-position).normalized().angle()
