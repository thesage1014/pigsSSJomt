extends Panel

# Declare member variables here. Examples:
class_name AttackRoller1
var activeAttack
onready var player = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("on_update_roller", self, "update_roller")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_roller(attacks, newAttack):
	if attacks.size() == 0 :
		attacks.append("die i guess?")
	activeAttack = attacks[newAttack]
	
	get_node("ActiveAttack").text = activeAttack
	#print(get_node("ActiveAttack").get_parent().name)
	if(newAttack >= attacks.size()-1):
		get_node("UpAttack").text = attacks[0]
	else:
		get_node("UpAttack").text = attacks[newAttack+1]
	if(newAttack <= 0):
		get_node("DownAttack").text = attacks[attacks.size()-1]
	else:
		get_node("DownAttack").text = attacks[newAttack-1]
