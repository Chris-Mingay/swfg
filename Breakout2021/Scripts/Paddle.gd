extends KinematicBody2D
class_name Paddle

var ball_scene
var Sfx_HitBall

func _ready():
	ball_scene = load("res://Scenes/Ball.tscn")
	Sfx_HitBall = load("res://SoundEffects/POP Brust 02.wav")
	$CircleDrawer.radius = $Collision.shape.radius
	$CircleDrawer.fill_color = Color(0.75,0.75,0.75,1)
	$CircleDrawer.border_color = Color(0.2,0.2,0.2,1)
	$CircleDrawer.border_width = 1
	$CircleDrawer.draw_fill = true
	$CircleDrawer.draw_border = true
	pass

func _physics_process(delta):
	self.position.x = get_viewport().get_mouse_position().x
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		for ball in get_parent().get_children():
			if ball is Ball:
				ball.attract_to_point(position,0)
	
func _input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		var bodies = $AreaOfEffect.get_overlapping_bodies()
		var ball_hit = false;
		for body in bodies:
			if body is Ball:
				var direction = body.get_position() - get_position()
				var distance = direction.length()
				var max_distance = get_node("AreaOfEffect").get_node("Collision").shape.radius
				if distance <= max_distance:
					ball_hit = true
					var power = 1 - distance / max_distance
					var max_power = Ball.MAXSPEED
					var actual_power = max_power * power
					var velocity = direction.normalized() * actual_power
					body.set_linear_velocity(velocity)
					body.state = Ball.STATE.IN_PLAY
					
		if ball_hit:
			$AudioStreamPlayer2D.stream = Sfx_HitBall
			$AudioStreamPlayer2D.play()
			
	

