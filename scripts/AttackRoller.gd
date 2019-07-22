extends Panel

# Declare member variables here. Examples:
class_name AttackRoller1
var activeAttack
#onready var player = get_parent()
export(NodePath) onready var player = get_node(player)


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("on_update_roller", self, "update_roller")
	if(player.playerNumber == 1):
		rect_scale *= Vector2(-1,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_roller(attacks, newAttack):
	activeAttack = attacks[newAttack][1]
	
	get_node("ActiveAttack").text = activeAttack
	#print(get_node("ActiveAttack").get_parent().name)
	if(newAttack >= attacks.size()-1):
		get_node("UpAttack").text = attacks[0][1]
	else:
		get_node("UpAttack").text = attacks[newAttack+1][1]
	if(newAttack <= 0):
		get_node("DownAttack").text = attacks[attacks.size()-1][1]
	else:
		get_node("DownAttack").text = attacks[newAttack-1][1]


func _on_Fighter1_on_player_selected():
	get_node("UpAttack").visible = false
	visible = false
	get_node("DownAttack").visible = false


func _on_Fighter1_on_send_attack():
	get_node("UpAttack").visible = true
	visible = true
	get_node("DownAttack").visible = true
