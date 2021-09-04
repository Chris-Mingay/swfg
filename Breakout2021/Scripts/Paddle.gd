extends KinematicBody2D

const ball_scene = preload("res://Scenes/Ball.tscn")

func _ready():
	# set_process_input(true)
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		var ball = ball_scene.instance()
		ball.set_position(get_position() - Vector2(0,16))
		get_tree().get_root().add_child(ball)
