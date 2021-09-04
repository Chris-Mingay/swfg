extends RigidBody2D

const SPEEDUP = 40
const MAXSPEED = 300

func _ready():
	pass

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
			
		if body.get_name() == "Paddle":
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_node("Anchor").get_global_position()
			var velocity = direction.normalized() * min(speed+SPEEDUP, MAXSPEED)
			set_linear_velocity(velocity)
