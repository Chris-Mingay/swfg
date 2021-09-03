extends RigidBody2D

func _ready():
	pass

func _physics_process(delta):
	var bodies = get_colliding_bodies()
