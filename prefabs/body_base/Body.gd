extends Area2D

export(float)var sprite_size = 32

export(bool)var is_player_base = false

export(String)var planet_name = "N/A"
var population = 100
var resistance = 0

var repopulating = true
var repopulation_rate = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	$Info.hide()
	$MouseLeaveDetector.show()
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = sprite_size
	update_display()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_display():
	$Info/PlanetName.text =str("Name: ",planet_name) 
	$Info/Population.text = str("Population: ",population)
	$Info/Resistance.text = str("Resistance: ",resistance)

func _on_Body_mouse_entered():
	$Info/MenuAP.play("show")


func _on_MouseLeaveDetector_mouse_exited():
	$Info.hide()


func _on_Raid_button_down():
	$Info.hide()
