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
var OMTAnim = ['OMT','One More Time', -100]
onready var hpStartSize = get_node("HealthBar").rect_size
export(NodePath) onready var enemy = get_node(enemy)
export var playerNumber = 1
export var hitPoints = 100.0
export var dead = false
var btn = []
var alreadySelected = false
var alreadyResurrected = false
signal on_update_roller
signal on_player_selected
signal on_send_attack
var removingMove = false
var sendingAttack = false

onready var anim = $Skeleton/AnimationPlayer
onready var healthBar = $HealthBar
#export(NodePath) onready var timer = get_node("Timer")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Set inputs per player
	if playerNumber == 1 :
		btn = ['p1_a','p1_b','p1_c']
	elif playerNumber == 2:
		btn = ['p2_a','p2_b','p2_c']
	#reset pose
	reset()
	
	


				
func _input(event):
	if event.is_action("reset"): reset()
	CheckLength()
	if  MoveList.size() > 0 && event.is_action_pressed(btn[0]) :
		alreadySelected = true
		emit_signal("on_player_selected")
		
	if(not alreadySelected):
		if event.is_action_released(btn[1]):
			nextMove -= 1
		elif event.is_action_released(btn[2]):
			nextMove += 1
	CheckLength()


func sendAttack():
	print_debug(playerNumber, " throwing ", MoveList[nextMove][1])
	CheckLength()
	emit_signal("on_send_attack")
	alreadySelected = false
	if MoveList.size() > 0 && !dead:
		#print(MoveList)
		if MoveList[nextMove][0] == "OMT":
			print("omt")
			anim.clear_queue()
			anim.current_animation = "OMT"
			self.MoveList = [
				['punchR','Lo Punch',30],
				['punchL','Hi Punch',50],
				['blockHi','Hi Block',0],
				['blockLo','Lo Block',0],
				['kickR','Hi Kick',50],
				['kickL','Lo Kick',30]
				]
			self.TakeDamage(OMTAnim)
			alreadyResurrected = true
		else:
			enemy.TakeDamage(MoveList[nextMove])
			anim.current_animation = MoveList[nextMove][0]
		
		removingMove = true
		if MoveList.size() == 1 or hitPoints <= 0:
			if !alreadyResurrected:
				MoveList.append(OMTAnim)
				
				
	else:
		MoveList = [
		["idle", "GAME", 0],
		["idle", "OVER", 0],
		["idle", "...", 0],
		["idle", "Thanks", 0],
		["idle", "for", 0],
		["idle", "playing!", 0],
		["idle", "You really", 0],
		["idle", "did a good", 0],
		["idle", "job, and", 0],
		["idle", "you shouldn't", 0],
		["wriggle", "feel bad", 0],
		["idle", "even though", 0],
		["idle", "you lost", 0],
		
		]


func CheckLength():
	if MoveList.size() == 0:
		MoveList.append(WriggleAnim)
#		nextMove = 0
	
	if nextMove > MoveList.size()-1:
		nextMove = 0
	elif nextMove < 0:
		nextMove = MoveList.size()-1


func TakeDamage(attack):
	var enemyAttack = attack[1]
	var damage = attack[2]
	var myAttack = MoveList[nextMove][1]
	#if(not MoveList[nextMove][0].begins_with("block")):
	print_debug("player ", playerNumber, " facing ", damage, "damage from a ", enemyAttack)
	if myAttack.ends_with("Block"):
		if myAttack.begins_with("Hi") && enemyAttack.begins_with("Hi"):
			print_debug("player ", playerNumber, "blocking High!")
			damage = 0
		if myAttack.begins_with("Lo") && enemyAttack.begins_with("Lo"):
			print_debug("player ", playerNumber, "blocking High!")
			damage = 0
	print_debug("player ", playerNumber, " taking ", damage, "damage!")
	hitPoints -= damage
	
	if hitPoints <= 0 && alreadyResurrected:
		dead = true
		get_node("./background").reset
		healthBar.visible = false
#	else:
#		get_node("HealthBar").visible = true
		#get_node("HealthBar").rect_size = hpStartSize * Vector2(hitPoints/100.0,1)
	
	hitPoints = clamp(hitPoints,0, 100)
	healthBar.rect_size.x = hitPoints*10
	healthBar.modulate.r = hitPoints/100
	healthBar.modulate.g = -hitPoints/100
	#print(hpStartSize * Vector2(hitPoints/100,1))
	print("player ", playerNumber, " has ", hitPoints, "hp")
	return hitPoints


func _process(delta):
	anim.playback_speed = rand_range(.8,1.7)
	if(removingMove):
		MoveList.remove(nextMove)
		removingMove = false
	if(sendingAttack):
		sendAttack()
		sendingAttack = false
	CheckLength()
	emit_signal("on_update_roller",MoveList,nextMove)


func _on_Timer_on_timed_attack():
	sendingAttack = true
		


func reset():
	hitPoints = 100.0
	dead = false
	alreadySelected = false
	alreadyResurrected = false
	removingMove = false
	sendingAttack = false
	anim.current_animation = "resetLimbs"
	MoveList = [
				['punchR','Lo Punch',30],
				['punchL','Hi Punch',50],
				['blockHi','Hi Block',0],
				['blockLo','Lo Block',0],
				['kickR','Hi Kick',50],
				['kickL','Lo Kick',30]
				]
	healthBar.rect_size.x = hitPoints*10
	healthBar.modulate.r = hitPoints/100
	healthBar.modulate.g = -hitPoints/100
