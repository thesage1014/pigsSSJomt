extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fade = 100
var timePerRound = 12
var timeLeft = timePerRound
var playerChose = 0
signal on_timed_attack
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLeft -= delta * (playerChose+1)
	
	get_node("Label").text = str(int(timeLeft+1))
	if(timeLeft <= 0):
		triggerAttack()
	elif(timeLeft < timePerRound*3/4):
		var fade = .05/timeLeft
		#$Spinner.visible = true
		#$Spinner.set("modulate.a", fade)
		$Spinner.modulate = Color(1,1,1,fade)
		$Spinner.scale = (Vector2.ONE*(timeLeft/timePerRound*7))
		$Spinner.transform = $Spinner.transform.rotated(-.1)
	else:
		#$Spinner.visible = false
		$Spinner.modulate.a = 0
		get_parent().get_node("background")._reset()
		
	
func triggerAttack():
	emit_signal("on_timed_attack")
	if(timePerRound > 1.5):
		timePerRound *= .9
	timeLeft = timePerRound+1
	playerChose = 0
	


func _on_Fighter1_on_player_selected():
	playerChose += 1


func _on_Fighter2_on_player_selected():
	playerChose += 1
