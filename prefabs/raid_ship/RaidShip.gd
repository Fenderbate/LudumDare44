extends Node2D

var target_pos = Vector2()
var dir = Vector2()
var speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if Global.selected_planet != null:
		if get_parent() == Global.selected_planet:
			return
		elif get_parent().name != "Game":
			var target = get_tree().root.get_node("Game")
			var source = self
			position += get_parent().position.rotated(get_parent().get_parent().rotation)
			get_parent().remove_child(source)
			target.add_child(self)
			set_owner(target)
		
		
		target_pos = Global.selected_planet.global_position-get_parent().global_position
		
		dir = (target_pos - position).normalized()
		
		if position.distance_to(target_pos) > 25:
			position += dir * speed
		else:
			var target = Global.selected_planet
			var source = self
			position = global_position - target.global_position
			get_parent().remove_child(source)
			target.add_child(self)
			set_owner(target)
			
	
