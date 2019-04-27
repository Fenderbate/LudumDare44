extends Node2D

var planet_orbit_speed = 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	for pivot in get_children():
		if pivot is Position2D:
			if pivot.get_child(0).name != "Robobase":
				pivot.get_child(0).connect("captured",get_parent(),"_on_planet_captured")
			pivot.rotation = deg2rad(rand_range(0,361))
	
	update()
	

func _physics_process(delta):
	
	for pivot in get_children():
		if pivot is Position2D:
			pivot.rotation += planet_orbit_speed - abs(pivot.get_child(0).position.x * 0.000001)
			pivot.get_child(0).rotation = -pivot.rotation

func _draw():
	
	for pivot in get_children():
		draw_empty_circle(position, Vector2(pivot.get_child(0).position.x,0),Color.white)
		

func draw_empty_circle(circle_center, circle_radius, color):
	var line_origin = Vector2()
	var line_end = Vector2()
	line_origin = circle_radius + circle_center

	for i in 361:
		line_end = circle_radius.rotated(deg2rad(i)) + circle_center
		draw_line(line_origin,line_end,Color.white,1,true)
		line_origin = line_end
