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

func _draw():
	var radius = get_node("Collision").shape.radius
	var angle_from = 0
	var angle_to = 359
	var color = Color(1.0, 0.0, 0.0)
	
	if active:
		radius += 2
		color = Color(1.0, 1.0, 0.0)
	
	draw_circle_arc(Vector2(0,0), radius, angle_from, angle_to, color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
        # points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func activate():
	$AudioStreamPlayer2D.stream = ActivationSound
	$AudioStreamPlayer2D.pitch_scale = rng.randfn(0.8,1.2)
	$AudioStreamPlayer2D.play()
	active = true
	activation_timer = Timer.new()
	activation_timer.connect("timeout",self,"_on_timer_timeout") 
	activation_timer.wait_time = active_delay
	add_child(activation_timer)
	activation_timer.start()

func _on_timer_timeout():
	active = false
