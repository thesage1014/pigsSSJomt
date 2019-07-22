extends ColorRect

# Declare member variables here. Examples:
var scale
onready var player = get_node(".")
var transform

# Called when the node enters the scene tree for the first time.
func _ready():
	transform = self.get_transform()
	scale = transform.get_scale()
	print_debug("hb scale: ", scale)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		transform.scaled() -= new Vector2(1,0)
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass