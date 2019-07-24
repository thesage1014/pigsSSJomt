extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fade = 100
export var setTimePerRound = 12
export var force_timer = 0
var timeLeft = setTimePerRound
var timePerRound = setTimePerRound
var playerChose = 0
signal on_timed_attack
# Called when the node enters the scene tree for the first time.
func _ready():
	fade = 100
	timePerRound = setTimePerRound
	playerChose = 0
	$Spinner.modulate.a = 0
	timeLeft = timePerRound

func _input(event):
	if event.is_action("reset"): 
		get_tree().reload_current_scene()
#		get_parent().get_node("one_more_time").play(0)
#		#get_node("bgm").play(0)
#		_ready()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeLeft -= delta * (playerChose + force_timer)
	
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
		timePerRound = setTimePerRound
		get_parent().get_node("background").reset()
		
	
func triggerAttack():
	emit_signal("on_timed_attack")
	if(timePerRound > 1.5):
		timePerRound *= .3
	timeLeft = setTimePerRound+1
	playerChose = 0
	


func _on_Fighter1_on_player_selected():
	playerChose += 1


func _on_Fighter2_on_player_selected():
	playerChose += 1
