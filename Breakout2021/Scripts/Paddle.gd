extends KinematicBody2D
class_name Paddle

var ball_scene

func _ready():
	ball_scene = load("res://Scenes/Ball.tscn")
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x
