extends Node2D

const ball_scene = preload("res://Scenes/Ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		var ball = ball_scene.instance()
		ball.set_position(Vector2(320,200))
		add_child(ball)
