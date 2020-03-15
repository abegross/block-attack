extends Container

onready var scl = Vector2(25.313, 38.813)
onready var screen = rect_size
onready var brightness = $CanvasLayer/background/env.environment.glow_bloom

#var newscale : Vector2
var newscreen : Vector2
var ratio : Vector2

#var chromatic_aberration = 0.00 setget set_offset

func _draw():
	newscreen = get_viewport_rect().size
	ratio.x = newscreen.x / screen.x
	ratio.y = newscreen.y / screen.y
	rect_scale = Vector2(scl.x * ratio.x, scl.y * ratio.y)
	print(rect_scale)

#
#func set_offset(value):
#	chromatic_aberration = value
#	$shader.material.set_shader_param('ca', chromatic_aberration)
#	print('ca ',chromatic_aberration)
