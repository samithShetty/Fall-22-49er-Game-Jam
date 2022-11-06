extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var reindeerSpawned = 0
var scoreSinceSpawn = 0
var timerValue = 10
var timeSinceSpawned = 0
var elfScene = preload("res://Elf.tscn")
var reindeerScene = preload("res://reindeer.tscn")
var santaScene = preload("res://Santa.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if timeSinceSpawned > 0:
		timeSinceSpawned -= delta
	else:
		timeSinceSpawned = timerValue
		var elf 
		
		timerValue = max(timerValue * .9, 2) 
		if Score.getScore() - scoreSinceSpawn >= 100:
			if reindeerSpawned < 10:
				scoreSinceSpawn = Score.getScore()
				elf = reindeerScene.instance()
				
				reindeerSpawned += 1
			else:
				elf = santaScene.instance()
		else:
			elf = elfScene.instance()
		
		
		add_child(elf)
		elf.position = ((-$Snowman.position).normalized() * 1500) + $Snowman.position

