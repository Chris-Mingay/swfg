extends KinematicBody2D

func _ready():
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x


