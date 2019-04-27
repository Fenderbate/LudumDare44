extends Area2D

export(float)var sprite_size = 32

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

# Called when the node enters the scene tree for the first time.
func _ready():
	$Info.hide()
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = sprite_size
	$RegenTimer.wait_time = regen_time_interval
	update_display()
	




func update_display():
	$Info/PlanetName.text =str("Name: ",planet_name) 
	$Info/Population.text = str("Population: ",population)
	$Info/Resistance.text = str("Resistance: ",resistance_power)


func raid(raid_power):
	resistance_power -= raid_power
	population -= floor(rand_range(0,3))
	if resistance_power <= 0 or population <= 0:
		resisting = false
		is_player_base = true
		if population < 0:
			population = 0
			


func _on_Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		$Info/MenuAP.play("show")


func _on_Raid_button_down():
	$Info.hide()


func _on_Close_button_down():
	$Info.hide()


func _on_RegenTimer_timeout():
	if resisting:
		resistance_power += resistance_power_regen
		if resistance_power > MAX_RESISTANCE_POWER:
			resistance_power = MAX_RESISTANCE_POWER
	if repopulating:
		population += repopulation_rate
		if population > MAX_POPULATION:
			population = MAX_POPULATION
	update_display()
