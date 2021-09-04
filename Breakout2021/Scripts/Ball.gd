extends RigidBody2D
class_name Ball

const SPEEDUP = 40
const MAXSPEED = 500

func _ready():
	pass

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body is Brick:
			body.queue_free()
			
		if body is Paddle:
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_node("Anchor").get_global_position()
			var velocity = direction.normalized() * min(speed+SPEEDUP, MAXSPEED)
			set_linear_velocity(velocity)
			
		if body is Bumper:
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_global_position()
			var velocity = direction.normalized() * MAXSPEED
			set_linear_velocity(velocity)
			body.activate()
	
	if get_position().y > get_viewport_rect().end.y:
		queue_free()
