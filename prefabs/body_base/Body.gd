extends Area2D

signal captured(planet)

export(float)var sprite_size = 32
export(float)var circle_radius = 64

export(bool)var is_player_base = false

export(String)var planet_name = "N/A"

var population = 100

export(float)var regen_time_interval = 1

var repopulating = true
var repopulation_rate = 1
export(float)var MAX_POPULATION = 100

var resisting = true
var resistance_power = 100
var resistance_power_regen = 1
export(float)var MAX_RESISTANCE_POWER = 100

var circle_color = Color.white

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = sprite_size
	$RegenTimer.wait_time = regen_time_interval
	
	resistance_power = MAX_RESISTANCE_POWER
	population = MAX_POPULATION
	
func _process(delta):
	
	if Global.selected_planet == self and circle_color != Color("995555"):
		circle_color = Color("995555")
	if is_player_base and circle_color != Color("569955"):
		circle_color = Color("569955")
	update()

func _draw():
	
		if Global.selected_planet == self or is_player_base:
			draw_empty_circle(Vector2(),Vector2(circle_radius,0),circle_color)
		


func raid(raid_power):
	if is_player_base:
		return
	resistance_power -= raid_power
	population -= floor(rand_range(0,3))
	if resistance_power <= 0 or population <= 0:
		resisting = false
		is_player_base = true
		emit_signal("captured",self)
		if population < 0:
			population = 0
		if resistance_power < 0:
			resistance_power = 0
			


func draw_empty_circle(circle_center, circle_radius, color):
	var line_origin = Vector2()
	var line_end = Vector2()
	line_origin = circle_radius + circle_center

	for i in 361:
		line_end = circle_radius.rotated(deg2rad(i)) + circle_center
		draw_line(line_origin,line_end,color,2,true)
		line_origin = line_end

func _on_Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		Global.selected_planet = self



func _on_RegenTimer_timeout():
	if resisting:
		if get_child_count() > 3:
			return
		resistance_power += resistance_power_regen
		if resistance_power > MAX_RESISTANCE_POWER:
			resistance_power = MAX_RESISTANCE_POWER
	if repopulating:
		population += repopulation_rate
		if population > MAX_POPULATION:
			population = MAX_POPULATION


