extends RigidBody2D
class_name Ball

const MAXSPEED = 250

enum STATE { READY, IN_PLAY, LOCKED }

export var state = STATE.READY

var Sfx_HitCore
var Sfx_HitBrick
var Sfx_HitBrickDud


const TARGET_REST = Vector2(128,192)
export var TARGET_REST_DEADZONE = 0
export var TARGET_REST_RATE = 1
export var TARGET_MAX_SPEED = 100

var attract_vector = Vector2(0,0)

func _ready():
	Sfx_HitCore = load("res://SoundEffects/IMPACT Hit Short Clink 01.wav")
	Sfx_HitBrick = load("res://SoundEffects/DESTRUCTION Break Impact Wood 04.wav")
	Sfx_HitBrickDud = load("res://SoundEffects/IMPACT Metal Hit Short 01.wav")
	
	$CircleDrawer.radius = $Collision.shape.radius
	$CircleDrawer.fill_color = Color(0.75,0.75,0.75,1)
	$CircleDrawer.border_color = Color(0.4,0.4,0.4,1)
	$CircleDrawer.border_width = 1
	$CircleDrawer.draw_fill = true
	$CircleDrawer.draw_border = true
	
	pass

func _physics_process(delta):
	
	_update_line_aim()
	
	match state:
		STATE.READY:
			_state_ready(delta)
		STATE.IN_PLAY:
			pass
		STATE.LOCKED:
			pass
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body is Brick:
			_hit_brick(body)

		if body is Bumper:
			var speed = get_linear_velocity().length()
			var direction = get_position() - body.get_global_position()
			var velocity = direction.normalized() * MAXSPEED
			set_linear_velocity(velocity)
			body.activate()
	
	if get_position().y > get_viewport_rect().end.y:
		queue_free()

func _state_ready(delta):
	attract_to_point(TARGET_REST,TARGET_REST_DEADZONE)
	

const MAX_AIM_WIDTH = 10
const AIM_MULTIPLIER = 1.25


func _update_line_aim():
	var paddle = get_tree().get_root().get_node("World").get_node("Paddle")
	var max_distance = paddle.get_node("AreaOfEffect").get_node("Collision").shape.radius
	var direction = global_position - paddle.global_position
	var distance = direction.length()
	var power = 1 - distance / max_distance
	var length = max_distance * power * 1.25
	
	$LineAim.visible = distance <= max_distance
	$LineAim.width = power * MAX_AIM_WIDTH
	$LineAim.points[1] = (global_position - paddle.global_position).normalized() * length;
	$LineAim.material.set_shader_param("mix_amount",power)

func _update_circle():
	pass




func _on_Ball_body_entered(body):
	if body.get_name() == "Paddle":
		$AudioStreamPlayer2D.stream = Sfx_HitCore
		$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
		$AudioStreamPlayer2D.play()

func attract_to_point(point : Vector2, deadzone : float):
	var velocity = get_linear_velocity()
	
	if position.x < point.x - deadzone:
		velocity.x += TARGET_REST_RATE
	elif position.x > point.x + deadzone:
		velocity.x -= TARGET_REST_RATE
		
	if position.y < point.y - deadzone:
		velocity.y += TARGET_REST_RATE
	elif position.y > point.y + deadzone:
		velocity.y -= TARGET_REST_RATE
		
	velocity.x = clamp(velocity.x,-TARGET_MAX_SPEED,TARGET_MAX_SPEED)
	velocity.y = clamp(velocity.y,-TARGET_MAX_SPEED,TARGET_MAX_SPEED)
	
	set_linear_velocity(velocity)


func _hit_brick(brick: Brick):
	var speed = get_linear_velocity()
	set_linear_velocity(speed*0.8)
	
	var brick_is_brock = false
	
	
	match brick.Type:
		Brick.TYPES.STANDARD:
			brick_is_brock = true
		Brick.TYPES.NEEDS_FAST:
			if speed.length() > Brick.BREAK_THRESHOLD:
				brick_is_brock = true	
		Brick.TYPES.NEEDS_SLOW:
			if speed.length() < Brick.BREAK_THRESHOLD:
				brick_is_brock = true
	
	if brick_is_brock:
		$AudioStreamPlayer2D.stream = Sfx_HitBrick
		$AudioStreamPlayer2D.set_volume_db(0)
		$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
		$AudioStreamPlayer2D.play()
		brick.queue_free()
	else:
		var volume = (1 - speed.length() / Brick.BREAK_THRESHOLD) * -25
		$AudioStreamPlayer2D.stream = Sfx_HitBrickDud
		$AudioStreamPlayer2D.set_volume_db(volume)
		$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
		$AudioStreamPlayer2D.play()
	
