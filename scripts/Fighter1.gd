extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextMove = 0
var moveCount = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_select"):
		print("Player 1 picked ", nextMove)
		
	elif event.is_action_released("ui_up"):
		nextMove += 1
		print(nextMove)
	elif event.is_action_released("ui_down"):
		nextMove -= 1
		print(nextMove)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !nextMove:
		nextMove = 0
	elif nextMove > moveCount:
		nextMove = 0
	elif nextMove < 0:
		nextMove = moveCount
#	pass
