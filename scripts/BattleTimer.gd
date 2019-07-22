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
	
func triggerAttack():
	emit_signal("on_timed_attack")
	timePerRound -= 1
	timeLeft = timePerRound
	playerChose = false
	
