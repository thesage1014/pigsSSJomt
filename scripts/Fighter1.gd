extends Node2D

var nextMove = 1
var MoveList = [
				'rest',
				'punchR',
				'punchL',
				'block',
				'kickR',
				'kickL',
				'grab',
				]
var MoveAmounts = []
var attackCards = []
export var playerNumber = 1
export var hitPoints = 100
var btn = []
onready var attackCard = preload("res://AttackCard.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if playerNumber == 1 :
		btn = ['p1_a','p1_b','p1_c']
	elif playerNumber == 2:
		btn = ['p2_a','p2_b','p2_c']
	#attackCard.text = 'yes'
	for i in range(MoveList.size()):
		MoveAmounts.append(0)
		attackCards.append(get_child(i))
	pass

func _input(event):
	if event.is_action_pressed(btn[0]) :
		get_node("Skeleton/AnimationPlayer").current_animation = MoveList[nextMove]
		MoveAmounts[nextMove] += 1
	elif event.is_action_released(btn[1]):
		nextMove -= 1
	elif event.is_action_released(btn[2]):
		nextMove += 1
	nextMove = getInArrayNumber(nextMove)
	
	#update UI
	update_roller()
	
func getInArrayNumber(num):
	if num >= MoveList.size():
		return 0
	if num < 0 :
		return MoveList.size()-1
	return num

func update_roller():
	for i in range(MoveList.size()) :		
		if (MoveAmounts[i] == 1):
			attackCards[i].text = (MoveList[i] + " - One MOre Time!!")
		elif (MoveAmounts[i] >= 0):
			attackCards[i].text = (MoveList[i] + " - NO MOre Times!!")
		else:		
			attackCards[i].text = (MoveList[i] + str(MoveAmounts[i]))
		
		if (i == nextMove || MoveAmounts[i] >= 0): 
			attackCards[i].add_color_override("font_color", Color("#ff0000"))
		else : 
			attackCards[i].add_color_override("font_color", Color("#333333"))
