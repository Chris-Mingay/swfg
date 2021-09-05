extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CircleDrawer.border_width = 2
	$CircleDrawer.draw_fill = false
	$CircleDrawer.antialised = false
	$CircleDrawer.border_color = Color(1,1,1,0.1)
	$CircleDrawer.radius = $Collision.shape.radius
	pass # Replace with function body.
