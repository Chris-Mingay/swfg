extends StaticBody2D

class_name Bumper

var activation_timer
var active = false
export var active_delay = 0.1

const ActivationSound = preload("res://SoundEffects/POP Brust 11.wav")

func _ready():
	pass
	
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
