extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timePerRound = 7
var timeLeft = timePerRound
var playerChose = false
signal on_timed_attack
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(playerChose):
		timeLeft -= delta*2
	else:
		timeLeft -= delta
	
	get_node("Label").text = str(int(timeLeft))
	if(timeLeft <= 0):
		triggerAttack()
	elif(timeLeft < timePerRound*3/4):
		get_node("Spinner").visible = true
		get_node("Spinner").scale = (Vector2.ONE*(timeLeft/timePerRound*7))
		get_node("Spinner").transform = get_node("Spinner").transform.rotated(-.1)
	else:
		get_node("Spinner").visible = false
	
func triggerAttack():
	emit_signal("on_timed_attack")
	timePerRound -= 1
	timeLeft = timePerRound+1
	playerChose = false
	


func _on_Fighter1_on_player_selected():
	playerChose = true


func _on_Fighter2_on_player_selected():
	playerChose = true
