extends Panel

# Declare member variables here. Examples:
class_name AttackRoller1
#var activeAttack
onready var player = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("on_update_roller", self, "update_roller")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func update_roller(MoveList, MoveAmounts, nextAttack):
#	var uiStrings = []
#	for i in range(MoveList.size()) :
#		uiStrings.append(MoveList[i] + str(MoveAmounts[i]))
#	for i in uiStrings:
#		#print_debug(i)
#		pass
#
#	#get_node("ActiveAttack").text = activeAttackName # " "  activeAttackAmount
#
#	#print(get_node("ActiveAttack").get_parent().name)
#	if(nextAttack >= MoveList.size()-1):
#		get_node("UpAttack").text = MoveList[0]
#	else:
#		get_node("UpAttack").text = MoveList[nextAttack+1]
#	if(nextAttack <= 0):
#		#get_node("DownAttack").text = MoveList[nextAttack-1]
#		pass
#	else:
#		get_node("DownAttack").text = MoveList[nextAttack-1]
