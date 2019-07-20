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


func _on_Fighter1_on_update_roller(newAttack):
	activeAttack = newAttack
	get_node("ActiveAttack").text = activeAttack
