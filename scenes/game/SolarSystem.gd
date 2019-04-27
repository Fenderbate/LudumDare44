extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	update()

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

func _physics_process(delta):
	
	for pivot in get_children():
		pivot.rotation += delta / 10
		pivot.get_child(0).rotation = -pivot.rotation
