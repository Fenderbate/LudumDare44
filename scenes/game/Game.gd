extends Node2D

var lives = 100

var required_lives = 200
var requirement_array = [200,300,400,600,1000,1200,2000,5000,10000]
var requirement_index = 0

var camera_dir = Vector2()
var move_camera = false

export(PackedScene)var victory = null
export(PackedScene)var lost = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	Global.robobase = $SolarSystem/Pivot2/Robobase
	set_payment(0)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2 or event.button_index == 3:
			if event.is_pressed():
				move_camera = true
			else:
				move_camera = false
		elif event.button_index == 5 and event.pressed and $Camera2D.zoom < Vector2(2,2):
			$Camera2D.zoom += Vector2(0.05,0.05)
		elif event.button_index == 4 and event.pressed and $Camera2D.zoom > Vector2(0.5,0.5):
			$Camera2D.zoom -= Vector2(0.05,0.05)
	if event is InputEventMouseMotion and move_camera:
		$Camera2D.position -= event.relative * $Camera2D.zoom.x

func show_planet_data(p_name, population, resistance):
	$UI/Info/Data.text = str("Name: ",p_name, "\n\nNumber of lifeforms: ", population, "M\n\nResistance: ", resistance)
	if Global.selected_planet.is_player_base:
		$UI/Info/Interact.text = "Claim Lives"
	else:
		$UI/Info/Interact.text = "Raid"

func _physics_process(delta):
	if Global.selected_planet != null:
		show_planet_data(Global.selected_planet.planet_name,Global.selected_planet.population,Global.selected_planet.resistance_power)
	else:
		pass
	$UI/Panel/PaymentTime.value = ($Utility/PaymentTimer.time_left / $Utility/PaymentTimer.wait_time)*100

func set_payment(payed_amount = 0):
	if payed_amount > lives:
		print("i can't pay more than what i have!")
		return
	elif payed_amount == lives:
		if lives > required_lives:
			lives -= required_lives
			required_lives = 0
	else:
		required_lives -= payed_amount
		lives -= payed_amount
		if lives < 0:
			lives = 0
	
	if required_lives <= 0:
		$Utility/PaymentTimer.start()
		requirement_index += 1
		if requirement_index >= requirement_array.size():
			print("the aliens got paid down... wut?")
			
		else:
			required_lives = requirement_array[requirement_index]
		
		print("notify the player that payment has increased!")
	
	$UI/Panel/Payment.text = str(required_lives,"M")
	$UI/Panel/Lives.text = str(lives,"M")


func _on_planet_captured(planet):
	print(str(planet.name," captured!"))
	if planet == Global.selected_planet:
		$UI/Info/Interact.text = "Claim lives"
	Global.raiding = false
	
	if planet.name == "Humpa":
		$UI.add_child(victory.instance())


func _on_Interact_button_down():
	if Global.selected_planet == Global.robobase:
		print("Can't raid your own base!")
		return
	
	if !Global.selected_planet.is_player_base:
		Global.raid_target = Global.selected_planet
		Global.raiding = true
		$UI/StopRaid.show()
	else:
		lives += Global.selected_planet.population / 2
		Global.selected_planet.population = floor(Global.selected_planet.population / 2)
		if Global.selected_planet.population <= 0:
			Global.selected_planet.repopulating = false
		set_payment()


func _on_StopRaid_button_down():
	Global.raiding = false
	Global.raid_target = null
	$UI/StopRaid.hide()

func _on_PaymentTimer_timeout():
	print("GAME OVERRRRRR")
	$UI.add_child(lost.instance())


func _on_Pay_button_down():
	set_payment(lives)
