extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hasEnteredScreen = false
export var speed = 1000
export var acceleration = 8.0
# Called when the node enters the scene tree for the first time.
func _ready():
	($AudioStreamPlayer2D.stream as AudioStreamMP3).loop = false

func _physics_process(delta):
	#linear_velocity = Vector2(clamp(linear_velocity.x,-speed,speed),clamp(linear_velocity.y,-speed,speed))
	
	var direction = (get_parent().get_node("Snowman").position - position)
	
	
	
	direction = direction.normalized()
	
	var x = direction.x
	var y = direction.y
	
	apply_impulse(Vector2(0,0),Vector2(acceleration*x,acceleration*y))
	
	look_at(direction + position)
	if position.length() > 2500:
		Score.call("addToScore", 100)
		queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	body.moveAngle = (body.position-position).normalized().angle()


func _on_VisibilityNotifier2D_screen_entered():
	if !hasEnteredScreen:
		hasEnteredScreen = true
		$AudioStreamPlayer2D.play()
		

