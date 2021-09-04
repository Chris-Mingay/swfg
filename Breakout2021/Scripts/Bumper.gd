extends StaticBody2D

class_name Bumper

var activation_timer
var active = false
export var active_delay = 0.25

const ActivationSound = preload("res://SoundEffects/POP Brust 11.wav")

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.
	
func _process(delta):
    update()

func activate():
	$AudioStreamPlayer2D.stream = ActivationSound
	$AudioStreamPlayer2D.set_pitch_scale(rand_range(0.98,1.02))
	$AudioStreamPlayer2D.play()
	$Sprite.set_frame(1)
	activation_timer = Timer.new()
	activation_timer.connect("timeout",self,"_on_timer_timeout") 
	activation_timer.wait_time = active_delay
	add_child(activation_timer)
	activation_timer.start()

func _on_timer_timeout():
	active = false
	$Sprite.set_frame(0)
