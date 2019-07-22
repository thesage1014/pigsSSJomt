extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nextMove = 1
#var moveCount = 0
var MoveList = [
				['One More Time','One More Time'],
				['punchR','Lo Punch'],
				['punchL','Hi Punch'],
				['blockHi','Hi Block'],
				['blockLo','Lo Block'],
				['kickR','Hi Kick'],
				['kickL','Lo Kick']
				]
var usedOnce = []
export var playerNumber = 1
export var hitPoints = 100
var btn = []
var alreadySelected = false
signal on_update_roller
signal on_player_selected
signal on_send_attack
#export(NodePath) onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	#moveCount = MoveList.size() -1 # for some reason it counts size from 1 but calls array members from 0, so calling array[array.size] causes a crash
	#print("move count: ", moveCount)
	var animList = get_node("Skeleton/AnimationPlayer").get_animation_list()
	
	#MoveList = animList

	if playerNumber == 1 :
		btn = ['p1_a','p1_b','p1_c']
	elif playerNumber == 2:
#		get_node("Skeleton/Torso/neck/head").frame = 1
		btn = ['p2_a','p2_b','p2_c']
	#reset pose
	get_node("Skeleton/AnimationPlayer").current_animation = "resetLimbs"

func _input(event):
	CheckLength()
	if  MoveList.size() > 0 && event.is_action_pressed(btn[0]) :
		alreadySelected = true
		emit_signal("on_player_selected")
		
	if(not alreadySelected):
		if event.is_action_released(btn[1]):
			nextMove += 1
		elif event.is_action_released(btn[2]):
			nextMove -= 1


	CheckLength()
	if MoveList.size() > 0 :
		emit_signal("on_update_roller",MoveList,nextMove)

func sendAttack():
	CheckLength()
	emit_signal("on_send_attack")
	alreadySelected = false
	if MoveList.size()-1 > 0 :
		get_node("Skeleton/AnimationPlayer").current_animation = MoveList[nextMove][0]
		if usedOnce.has(MoveList[nextMove][0]) :
			usedOnce.remove(MoveList[nextMove][0])
			MoveList.remove(nextMove)

		else :
			usedOnce.append(MoveList[nextMove][0])


func CheckLength():
	if nextMove > MoveList.size()-1:
		nextMove = 0
	elif nextMove < 0:
		nextMove = MoveList.size()-1
	return
	
func TakeDamage(damage):
	hitPoints -= damage
	return hitPoints
	
func _process(delta):
	get_node("Skeleton/AnimationPlayer").playback_speed = rand_range(.7,1.4)


func _on_Timer_on_timed_attack():
	print("sent")
	sendAttack()
