extends Node2D

var currency = 100


var camera_dir = Vector2()
var move_camera = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		print(event.button_index)
	if event is InputEventMouseButton:
		if event.button_index == 2 or event.button_index == 3:
			if event.is_pressed():
				move_camera = true
			else:
				move_camera = false
		elif event.button_index == 5 and event.pressed and $Camera2D.zoom < Vector2(2,2):
			$Camera2D.zoom += Vector2(0.05,0.05)
		elif event.button_index == 4 and event.pressed and $Camera2D.zoom > Vector2(0.1,0.1):
			$Camera2D.zoom -= Vector2(0.05,0.05)
	if event is InputEventMouseMotion and move_camera:
		$Camera2D.position -= event.relative * $Camera2D.zoom.x

func show_planet_data(p_name, population, resistance):
	$UI/Info/Data.text = str("Name: ",p_name,"\n\nNumber of lifeforms: ",population,"M\n\nResistance: ",resistance)

func _physics_process(delta):
	if Global.selected_planet != null:
		show_planet_data(Global.selected_planet.planet_name,Global.selected_planet.population,Global.selected_planet.resistance_power)
	else:
		pass
	

