extends Control

# Declare member variables here. Examples:
onready var r_pos = $bg_r.rect_position
onready var g_pos = $bg_g.rect_position
onready var b_pos = $bg_b.rect_position
onready var red_pos_reset = $bg_r.rect_position
onready var green_pos_reset = $bg_g.rect_position
onready var blue_pos_reset = $bg_b.rect_position

export var magnitude = 10
export var rotation_magnitude = 0.25
export var reset_chroma = true


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func _input(event):
	
	if event.is_action_pressed("p1_a"):
		var newx = r_pos.x + magnitude
		var y = r_pos.y
		$bg_r.set("rect_position", Vector2(newx, y))
		$bg_r.rect_rotation += rotation_magnitude
		 
	if event.is_action_pressed("p1_b"):
		var newx = g_pos.x + magnitude
		var y = g_pos.y
		$bg_g.set("rect_position", Vector2(newx, y))
		$bg_g.rect_rotation += rotation_magnitude
		
	if event.is_action_pressed("p1_c"):
		var newx = b_pos.x + magnitude
		var y = b_pos.y
		$bg_b.set("rect_position", Vector2(newx, y))
		$bg_b.rect_rotation += rotation_magnitude
		
	if event.is_action_pressed("p2_a"):
		var newx = r_pos.x - magnitude
		var y = r_pos.y
		$bg_r.set("rect_position", Vector2(newx, y))
		$bg_r.rect_rotation += -rotation_magnitude
		
	if event.is_action_pressed("p2_b"):
		var newx = g_pos.x - magnitude
		var y = g_pos.y
		$bg_g.set("rect_position", Vector2(newx, y))
		$bg_g.rect_rotation += -rotation_magnitude
		
	if event.is_action_pressed("p2_c"):
		var newx = b_pos.x - magnitude
		var y = b_pos.y
		$bg_b.set("rect_position", Vector2(newx, y))
		$bg_b.rect_rotation += -rotation_magnitude
	if event.is_action("reset"): reset()
	
func reset() :
	if reset_chroma :
		$bg_r.rect_position = red_pos_reset
		$bg_g.rect_position = red_pos_reset
		$bg_b.rect_position = red_pos_reset
		$bg_r.rect_rotation = 0
		$bg_g.rect_rotation = 0
		$bg_b.rect_rotation = 0

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
