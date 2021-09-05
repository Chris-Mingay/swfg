extends Node2D

class_name CircleDrawer

export var radius : float = 10
export var angle_from : float = 0
export var angle_to : float = 360
export var border_color = Color(1,1,1,1)
export var fill_color = Color(1,1,1,1)
export var border_width : float = 1
export var antialised : bool = true
export var draw_border : bool = true
export var draw_fill : bool = false

func _draw():
	if draw_fill:
		draw_circle_arc_poly(position, radius, angle_from, angle_to, fill_color)
	
	if draw_border:
		draw_circle_arc(position, radius, angle_from, angle_to, border_color, border_width, antialised)
	
func draw_circle_arc(center, radius, angle_from, angle_to, color, line_width = 1, antialised = false):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color, line_width, antialised)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    var colors = PoolColorArray([color])

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)
