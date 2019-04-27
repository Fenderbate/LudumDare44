extends Node2D

var currency = 100


var camera_dir = Vector2()
var move_camera = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == 2:
		if event.is_pressed():
			move_camera = true
		else:
			move_camera = false
		
	if event is InputEventMouseMotion and move_camera:
		$Camera2D.position -= event.relative

func _physics_process(delta):
	
	pass
	

func control_camera():
	if abs(get_viewport().get_mouse_position().y - 300) > 250 :
		print("asd")
		camera_dir.y = 1 if get_viewport().get_mouse_position().y - 300 > 0 else -1
	else:
		camera_dir.y = 0
	
	if abs(get_viewport().get_mouse_position().x - 512) > 480 :
		print("asd")
		camera_dir.x = 1 if get_viewport().get_mouse_position().x - 480 > 0 else -1
	else:
		camera_dir.x = 0
	
	#print(get_viewport().get_mouse_position().y - 300)
	
	$Camera2D.position += camera_dir
