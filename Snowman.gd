extends RigidBody2D

export var turn_speed = 0.05
export var speed = 500

var lookDir = Vector2(1,0)
var moveAngle = 0
var isJumping = false
var jumpTime = 0
var swingTime = 0
onready var waterTrail = preload("res://WaterTrail.tscn")


func _ready():
	($taco.stream as AudioStreamMP3).loop = false
	
func _physics_process(delta):

	if swingTime > 0:
		swingTime -= delta
		if swingTime <= 0:
			$SwordArea/CollisionShape2D.disabled = true
	
	if isJumping:
		jumpTime -= delta
		if jumpTime <= 0:
			isJumping = false
			$Sprites.scale.x = 1
			$Sprites.scale.y = 1
			var new_trail = waterTrail.instance()
			get_parent().add_child(new_trail)


	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("up") - Input.get_action_strength("down")
	
	if x and not isJumping: # Extra turn render rotation
		moveAngle += sign(x) * turn_speed
		lookDir = lookDir.slerp(Vector2(1,0).rotated(moveAngle + sign(x)*PI/2),0.1)
	else: # Normal Smooth render rotation
		lookDir = lookDir.slerp(Vector2(1,0).rotated(moveAngle),0.04)
		
	linear_velocity = Vector2(speed,0).rotated(moveAngle)
	rotation = lookDir.angle()

	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var waterCollision = space_state.intersect_ray(position, position + get_linear_velocity().rotated(-get_global_rotation()).normalized()*30, [self], 7, true, true)

	if position.length() > 2500:
		die()

func _input(event):
	if event.is_action_pressed("swing") and !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("swing")
		$SwordArea/CollisionShape2D.disabled = false
		swingTime = .4
		
func die():
	get_tree().change_scene("res://deathScreen.tscn")

	if event.is_action_pressed("jump") and !isJumping:
		isJumping = true
		$Sprites.scale.x = 1.2
		$Sprites.scale.y = 1.2
		jumpTime = .3

func _on_SwordArea_body_entered(body):
	body.apply_impulse(Vector2(0,0),(body.position - $SwordArea.global_position).normalized() * 2000)
