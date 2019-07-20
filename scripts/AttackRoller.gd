extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class_name AttackRoller1
var activeAttack = "Hi Punch"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Fighter1_on_update_roller(attacks, newAttack):
	activeAttack = attacks[newAttack]
	get_node("ActiveAttack").text = activeAttack
	if(newAttack >= attacks.size()-1):
		get_node("UpAttack").text = ""
	else:
		get_node("UpAttack").text = attacks[newAttack+1]
	if(newAttack <= 0):
		get_node("DownAttack").text = ""
	else:
		get_node("DownAttack").text = attacks[newAttack-1]
