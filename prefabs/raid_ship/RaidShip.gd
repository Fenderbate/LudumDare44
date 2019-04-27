extends Node2D

var target_pos = Vector2()
var dir = Vector2()
var speed = 0.8

var power = 1
var health = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	power += randi() % 5
	randomize_direction()
	$WanderTimer.wait_time = rand_range(0.5,5)
	$WanderTimer.start()

func _physics_process(delta):
	
	
	
	if Global.raid_target != null and Global.raiding:
		if get_parent() == Global.raid_target:
			return
		
		target_pos = Global.raid_target.global_position-get_parent().global_position
		
		dir = (target_pos - position).normalized()
		
		if position.distance_to(target_pos) > 25:
			position += dir * speed
		else:
			var target = Global.raid_target
			var source = self
			position = global_position - target.global_position
			get_parent().remove_child(source)
			target.add_child(self)
			set_owner(target)
			$AttackTimer.start()
	elif !Global.raiding:
		if get_parent().name != "Game":
			var target = get_tree().root.get_node("Game")
			var source = self
			position += get_parent().position.rotated(get_parent().get_parent().rotation)
			get_parent().remove_child(source)
			target.add_child(self)
			set_owner(target)
			randomize_direction()
		position += dir * speed * 0.25

func randomize_direction():
	if !Global.raiding:
		dir = Vector2(rand_range(-10,10),rand_range(-10,10)).normalized()

func _on_Timer_timeout():
	if get_parent() == Global.raid_target and get_parent().name != "Robobase":
		get_parent().raid(power)
		health -= floor(get_parent().resistance_power * 0.1)
		if health <= 0:
			queue_free()
		pass
	if get_parent() is Area2D and get_parent().resistance_power > 0 and !get_parent().is_player_base:
		$AttackTimer.start()


func _on_WanderTimer_timeout():
	randomize_direction()
