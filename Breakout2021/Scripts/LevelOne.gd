extends Node2D

const ball_scene = preload("res://Scenes/Ball.tscn")

const INIT_SPREAD = 50

#var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_MIDDLE:
		var ball = ball_scene.instance()
		var pos = Vector2(get_viewport_rect().size.x * .5, get_viewport_rect().size.y * .75)
		ball.set_position(pos)
		ball.set_linear_velocity(Vector2(rand_range(-INIT_SPREAD,INIT_SPREAD),rand_range(-INIT_SPREAD,INIT_SPREAD)))
		add_child(ball)

