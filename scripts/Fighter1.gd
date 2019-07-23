extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextMove = 1
#var moveCount = 0
var MoveList = [
				['punchR','Lo Punch',30],
				['punchL','Hi Punch',50],
				['blockHi','Hi Block',0],
				['blockLo','Lo Block',0],
				['kickR','Hi Kick',50],
				['kickL','Lo Kick',30]
				]
var WriggleAnim = ['wriggle','wriggle',0]
var OMTAnim = ['One More Time','One More Time', 0]
onready var hpStartSize = get_node("HealthBar").rect_size
export(NodePath) onready var enemy = get_node(enemy)
export var playerNumber = 1
export var hitPoints = 100.0
var btn = []
var alreadySelected = false
var alreadyResurrected = false
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

func sendAttack():
	CheckLength()
	emit_signal("on_send_attack")
	alreadySelected = false
	if MoveList.size() > 0:
		print(MoveList)
		if MoveList[0][0] == "One More Time":
			MoveList = [
				['punchR','Lo Punch',30],
				['punchL','Hi Punch',50],
				['blockHi','Hi Block',0],
				['blockLo','Lo Block',0],
				['kickR','Hi Kick',50],
				['kickL','Lo Kick',30]
				]
			hitPoints += 100.0
		else:
			enemy.TakeDamage(MoveList[nextMove][2])
		get_node("Skeleton/AnimationPlayer").current_animation = MoveList[nextMove][0]
		MoveList.remove(nextMove)
		if MoveList.size() == 0 and not alreadyResurrected:
				MoveList.append(OMTAnim)
				alreadyResurrected = true
	
func CheckLength():
	if MoveList.size() == 0:
		MoveList.append(WriggleAnim)
		nextMove = 0
	else:
		if nextMove > MoveList.size()-1:
			nextMove = 0
		elif nextMove < 0:
			nextMove = MoveList.size()-1
	
func TakeDamage(damage):
	if(MoveList.size() > nextMove and not MoveList[nextMove][0].begins_with("block")):
		hitPoints -= damage
	if hitPoints <= 0:
		get_node("HealthBar").visible = false
	else:
		get_node("HealthBar").visible = true
		get_node("HealthBar").rect_size = hpStartSize * Vector2(hitPoints/100.0,1)
	#print(hpStartSize * Vector2(hitPoints/100,1))
	print(hitPoints)
	return hitPoints
	
func _process(delta):
	get_node("Skeleton/AnimationPlayer").playback_speed = rand_range(.8,1.7)
	CheckLength()
	emit_signal("on_update_roller",MoveList,nextMove)

func _on_Timer_on_timed_attack():
	sendAttack()
