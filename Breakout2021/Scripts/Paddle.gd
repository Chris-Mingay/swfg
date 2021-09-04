extends KinematicBody2D
class_name Paddle

# const ball_scene = preload("res://Scenes/Ball.tscn")

func _ready():
	# set_process_input(true)
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x
