extends Camera2D

var magnitude = 0
var timeleft = 0
var is_shaking = false

onready var shader = $'../shader'

func shake(new_magnitude, new_lifetime, change):
	if is_shaking and magnitude > new_magnitude: return
	magnitude = new_magnitude
	timeleft = new_lifetime
	is_shaking = true


	shader.material.set_shader_param('ca', Vector3(0,0,0))
	var ca = shader.material.get_shader_param('ca')
	print(ca)
	change = change if randf()>.5 else -change
	while timeleft > 0:
#		print(magnitude)
#		if magnitude >= 20:
#			print('k')
#			shader.show()
		ca = shader.material.get_shader_param('ca') + Vector3(change, change, 0)
		shader.material.set_shader_param('ca', Vector3(ca.x, ca.y ,0))
		var pos = Vector2()
		pos.x = rand_range(-magnitude, magnitude)
		pos.y = rand_range(-magnitude, magnitude)
		position = pos
		print('in here ', ca)

		timeleft -= get_process_delta_time()
		yield(get_tree(), 'idle_frame')

	magnitude = 0
	is_shaking = false
	position = Vector2()

	var timeleft = 0.01
	while ca.x > 0:
		ca = shader.material.get_shader_param('ca')
		shader.material.set_shader_param('ca', Vector3(ca.x-timeleft, ca.y-timeleft,0))
		yield(get_tree(), 'idle_frame')
	shader.material.set_shader_param('ca', Vector3(0,0,0))