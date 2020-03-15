extends Control

# get the fingers position - will be updated each frame
var finger = Vector2()
var x
var y
var gameover = false
# the size of the play area. ÷ 2 is because the area is centered, so its '-width/2 to width/2', and not '0 to width'
onready var area_size = $background/ctrl_area.texture.get_width()/2
# the box shouldn't be able to go into the wall, so this gets the offset between the center of the box and the wall
onready var box_offset = 2.3*$player.scale.x
# the actual size of the ctrl_area
onready var ctrl_area = $background/ctrl_area
onready var play_area = $background/play_area
var is_teleporting : bool = false


func _ready():
	if gamemode.BUMPERS.is_current_gamemode() or gamemode.TELEPORT.is_current_gamemode():
		play_area.modulate = Color.white

	audio_player.start_sound()
	#if we restart the game, reset the score
	score_controller.reset()
	score_controller.connect('score_changed', self, "enemies_colliding")


#	var a = InputEventMouseButton.new()
#	a.set_button_index(1)
#	a.position = Vector2(540, 1404)#ctrl_area.to_global(Vector2())
#	print(a.position)
#	a.set_pressed(true)
#	Input.parse_input_event(a)


	#  start off slow mo
	var current_time = 0.0
	var duration = 0.5
	var tscale = 0.01
	while current_time < duration:
		Engine.time_scale = tscale
		tscale += 0.01
		current_time += get_process_delta_time()
		yield(get_tree(), 'idle_frame')

#	color.randomizer([background, [$enemies.get_children(), $color_holder/enemies], [ctrl_area, play_area, $hud.get_children()], [$player.get_node('sprite'), $color_holder/player]])
	for enemy in get_tree().get_nodes_in_group('enemy'):
		enemy.connect('hit', self, 'bump')


func _process(delta):
	finger = ctrl_area.get_local_mouse_position()
#	print(finger)

	x = clamp(finger.x, -area_size+box_offset, area_size-box_offset)
	y = clamp(finger.y, -area_size+box_offset, area_size-box_offset)

	if not gameover:
		match gamemode.current_gamemode:
			# REGULAR mode code:
			gamemode.REGULAR:
				move(10)

			# INTANGIBLE mode code:
			gamemode.INTANGIBLE:
				move(10)

			# TELEPORT mode code:
			gamemode.TELEPORT:
				if Input.is_action_just_pressed('press') and is_teleporting == false:
					is_teleporting = true
					$anim.play("vzhew-in")
					yield($anim, "animation_finished")
					# theres a frame after the block explodes where u can still reach this code, so this stops a crash
					if $player:
						$player.position = play_area.to_global(Vector2(x, y))
					$anim.play("vzhew-out")
					is_teleporting = false

			# BUMPERS mode code:
			gamemode.BUMPERS:
				move(15)
	update()


func move(speed):
	"""
	lerps (moves) the player to specified location
	args:
		speed:  a percentage of how far along the interpolation is.
	"""
	if has_node('player'):
#		play_area.to_global(Vector2(x,y))
		$player.position = $player.position.linear_interpolate(play_area.to_global(Vector2(x,y)), (get_process_delta_time() * speed))
		pass


func _on_gameover():
	progress.update_progress()
	if(Engine.has_singleton("AdMob")):
		var admob = Engine.get_singleton("AdMob")
		if admob != null and randi()%15==0: # 1 in 15 chance to show interstitial
			admob.showInterstitial()
	level_manager.goto_level(level_manager.menu_gameover)
	score_controller.gameover = false
	gamemode.current_gamemode.save_highscore()


#var time = 0.05
#var hits = 0
func enemies_colliding():
	"""
	makes the camera shake when enemies collide
	"""
	$camera.shake(3, 0.13, 0.0005)
#	hits += 1
#	time -= get_process_delta_time()
#	if time <= 0 and hits >= 4:
#		$camera.shake(hits, 0.13, 0.0006)
#		time = 0.05
#		hits = 0


func bump(enemy):
	"""
	makes the particle effect when enemies hit things
	args:
		enemy: the blocks that can kill you
	"""
#	print(enemy.name)
	var shockwave = preload("res://scenes/shockwave.tscn").instance()
	shockwave.position = enemy.position
	shockwave.modulate = enemy.get_node('sprite').modulate
	shockwave.get_node('anim').play("wave")
	$enemies.add_child(shockwave)
	var p = preload('res://scenes/particles.tscn').instance()
	p.modulate = enemy.get_node('sprite').modulate
	p.position = enemy.position
	p.emitting = true
	$enemies.add_child(p)


func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		get_tree().paused = true
		$CanvasLayer/panel.show()
