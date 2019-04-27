extends Node2D

export(Texture)var land = null
export(Texture)var clouds = null
export(Texture)var mask = null

export(float)var rotation_speed = 0.2

export(Color)var tone = Color.white

# Called when the node enters the scene tree for the first time.
func _ready():
	$Land.texture = land
	$Clouds.texture = clouds
	$Land.material.set_shader_param("speed",rotation_speed)
	$Clouds.material.set_shader_param("speed",rotation_speed * rand_range(0.85,1.15))
	$Land.material.set_shader_param("mask_texture",mask)
	$Clouds.material.set_shader_param("mask_texture",mask)
	modulate = tone

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
