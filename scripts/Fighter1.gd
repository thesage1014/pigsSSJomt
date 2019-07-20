extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextMove = 0
var moveCount = 0
var MoveList = [
				'rest',
				'punchR',
				'punchL',
				'block',
				'kickR',
				'kickL',
				'grab?',
				]
signal on_update_roller

# Called when the node enters the scene tree for the first time.
func _ready():
	moveCount = MoveList.size() -1 # for some reason it counts size from 1 but calls array members from 0, so calling array[array.size] causes a crash

	print("move count: ", moveCount)
	pass

func _input(event):



	if event.is_action_pressed("ui_select"):
		print("Player 1 picked ", MoveList[nextMove])
		#should probably call a function on the game control node and pass the selected move so it can trigger the timer and then play the animation?
		get_node("Skeleton/AnimationPlayer").current_animation = MoveList[nextMove]
	elif event.is_action_released("ui_up"):
		nextMove += 1
		CheckLength()
		print(MoveList[nextMove])
	elif event.is_action_released("ui_down"):
		nextMove -= 1
		CheckLength()
		print(MoveList[nextMove])
		
	emit_signal("on_update_roller",MoveList,nextMove)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func CheckLength():
	if nextMove > moveCount:
		nextMove = 0
	elif nextMove < 0:
		nextMove = moveCount
	pass
func _process(delta):
	#if !nextMove:
		#nextMove = 0
	if nextMove > moveCount:
		nextMove = 0
	elif nextMove < 0:
		nextMove = moveCount
	pass
