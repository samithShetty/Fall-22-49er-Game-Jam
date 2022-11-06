extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timerValue = 10
var timeSinceSpawned = 0
var elfScene = preload("res://Elf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if timeSinceSpawned > 0:
		timeSinceSpawned -= delta
	else:
		timeSinceSpawned = timerValue
		var elf = elfScene.instance()
		add_child(elf)
		elf.position = ((-$Snowman.position).normalized() * 1500) + $Snowman.position
		timerValue = max(timerValue * .9, 2) 
		

