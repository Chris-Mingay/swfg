extends RigidBody2D
class_name Ball

const SPEEDUP = 10
const MAXSPEED = 200

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
	pass

func _physics_process(delta):
	
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
			
			var speed = get_linear_velocity()
			set_linear_velocity(speed*0.8)
			if speed.length() > Brick.BREAK_THRESHOLD:
				$AudioStreamPlayer2D.stream = Sfx_HitBrick
				$AudioStreamPlayer2D.set_volume_db(0)
				$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
				$AudioStreamPlayer2D.play()
				body.queue_free()
			else:
				var volume = (1 - speed.length() / Brick.BREAK_THRESHOLD) * -25
				$AudioStreamPlayer2D.stream = Sfx_HitBrickDud
				$AudioStreamPlayer2D.set_volume_db(volume)
				$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
				$AudioStreamPlayer2D.play()

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
