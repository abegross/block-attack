extends RigidBody2D
onready var explosion_scene = preload("res://scenes/explosion.tscn")
var collider_pos = Vector2()
onready var board = $'../../board'
	# if an enemy hits me
func _on_player_body_entered(body):
#	print(body.name)
	if body.is_in_group('enemy') or (body.is_in_group('wall') and not gamemode.BUMPERS.is_current_gamemode() and not gamemode.TELEPORT.is_current_gamemode()):
		#go to the game over screen
#		print('gameover')
#		LevelManager.LoadLevel("2 Game Over")
		var wait_time
		if gamemode.BUMPERS.is_current_gamemode():
			wait_time = 1.5
		else:
			wait_time = 0.8
		var timer = Timer.new()
		timer.wait_time = wait_time
		timer.autostart = true
		board.add_child(timer)
		timer.connect('timeout', $'/root/board', '_on_gameover')
		explode(body, body.global_position)
		board.gameover = true
		score_controller.gameover = true
		audio_player.death_sound(wait_time)
#		while timer.time_left > 0:
		$'../camera'.shake(60, 0.5, 0.002)
#			yield(get_tree(), 'idle_frame')
#		var ca = $'../shader'.material.get_shader_param('ca')
#		while ca.x > 0:
#			$'../shader'.material.set_shader_param('ca', Vector3(ca.x-0.05, ca.y-0.05,0))
#			ca.x -= 0.05
#			yield(get_tree(), 'idle_frame')
#		$'../shader'.hide()
		#show an advertisement 1/15x
		#if (Random.value < 0.06) Advertisement.Show()
#	print('collision ', body.global_position)
	collider_pos = body.global_position
#	emit_signal('explode', body, collider_pos)
func explode(collider, collider_pos):
	var explosion = explosion_scene.instance()
	explosion.modulate = $'../../board/player/sprite'.modulate
	queue_free()
	explosion.global_position = global_position
	var rot = explosion.position.angle_to_point(collider_pos)
#	print(collider_pos, rot)
	explosion.rot = rot
	if collider.name == 'wall_left':
		explosion.rot = 0
	elif collider.name == 'wall_right':
		explosion.rot = PI
	elif collider.name == 'wall_top':
		explosion.rot = .5*PI
	elif collider.name == 'wall_bottom':
		explosion.rot = -.5*PI
	explosion.z_index = 2
#	explosion.emitting = true
#	yield(get_tree(), "idle_frame")
	$'../../board'.add_child(explosion)
	explosion.explode()
