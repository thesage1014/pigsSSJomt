extends Panel

# Declare member variables here. Examples:
class_name AttackRoller1
var activeAttack
var lastAttacks
#onready var player = get_parent()
export(NodePath) onready var player = get_node(player)


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("on_update_roller", self, "update_roller")
	if(player.playerNumber == 2):
		rect_scale *= Vector2(-1,1)


func reset():
	get_node("UpAttack").visible = true
	modulate.a = 1
	get_node("DownAttack").visible = true


func _input(event):
	if event.is_action_released("reset"): 
		reset()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_roller(attacks, newAttack):
	activeAttack = attacks[newAttack][1]
	lastAttacks = attacks
	get_node("ActiveAttack").text = activeAttack
	#print(get_node("ActiveAttack").get_parent().name)
	if(newAttack >= attacks.size()-1):
		get_node("DownAttack").text = attacks[0][1]
	else:
		get_node("DownAttack").text = attacks[newAttack+1][1]
	if(newAttack <= 0):
		get_node("UpAttack").text = attacks[attacks.size()-1][1]
	else:
		get_node("UpAttack").text = attacks[newAttack-1][1]


func _on_Fighter1_on_player_selected():
	get_node("UpAttack").visible = false
	modulate.a = .5
	get_node("DownAttack").visible = false


func _on_Fighter1_on_send_attack():
	reset()
#	get_node("UpAttack").visible = true
#	modulate.a = 1
#	get_node("DownAttack").visible = true
