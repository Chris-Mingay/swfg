extends KinematicBody2D
class_name Paddle

var ball_scene
var Sfx_HitBall


const MAX_SHOT_SPEED = 500

func _ready():
	ball_scene = load("res://Scenes/Ball.tscn")
	Sfx_HitBall = load("res://SoundEffects/POP Brust 02.wav")
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var balls = []
		for ball in get_parent().get_children():
			if ball is Ball:
				balls.append(ball)
		
		for ball in balls:
			ball.attract_to_point(position,0)
	
	
func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		var bodies = $AreaOfEffect.get_overlapping_bodies()
		var ball_hit = false;
		for body in bodies:
			if body is Ball:
				var direction = body.get_position() - get_position()
				var distance = abs(direction.length())
				var max_distance = get_node("AreaOfEffect").get_node("Collision").shape.radius
				if distance <= max_distance:
					ball_hit = true
					var power = 1 - distance / max_distance
					var max_power = 500
					var actual_power = max_power * power
					var velocity = direction.normalized() * actual_power
					body.set_linear_velocity(velocity)
					body.state = Ball.STATE.IN_PLAY
					
		if ball_hit:
			$AudioStreamPlayer2D.stream = Sfx_HitBall
			$AudioStreamPlayer2D.play()
			
	

