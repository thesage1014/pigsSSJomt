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
var usedOnce = []
export var playerNumber = 1
var btn = []
signal on_update_roller

# Called when the node enters the scene tree for the first time.
func _ready():
	#moveCount = MoveList.size() -1 # for some reason it counts size from 1 but calls array members from 0, so calling array[array.size] causes a crash
	
	#print("move count: ", moveCount)
	
	if playerNumber == 1 :
		btn = ['p1_a','p1_b','p1_c']
	elif playerNumber == 2:
		btn = ['p2_a','p2_b','p2_c']
	pass

func _input(event):
	


	if event.is_action_pressed(btn[0]):
		if usedOnce.has(MoveList[nextMove]):
			usedOnce.remove(nextMove)
			MoveList.remove(nextMove)
			#moveCount = MoveList.size() -1
		else :
			usedOnce.append(MoveList[nextMove])
			print(usedOnce)
			print("Player 1 picked ", MoveList[nextMove])
			#should probably call a function on the game control node and pass the selected move so it can trigger the timer and then play the animation?
			get_node("Skeleton/AnimationPlayer").current_animation = MoveList[nextMove]

	elif event.is_action_released(btn[1]):
		nextMove += 1
		CheckLength()
		print(MoveList[nextMove])
	elif event.is_action_released(btn[2]):
		nextMove -= 1
		CheckLength()
		print(MoveList[nextMove])

		
	emit_signal("on_update_roller",MoveList,nextMove)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func CheckLength():
	if nextMove > MoveList.size()-1:
		nextMove = 0
	elif nextMove < 0:
		nextMove = MoveList.size()-1
	pass
func _process(delta):
	#if !nextMove:
		#nextMove = 0
	if nextMove > MoveList.size()-1:
		nextMove = 0
	elif nextMove < 0:
		nextMove = MoveList.size()-1
	pass
