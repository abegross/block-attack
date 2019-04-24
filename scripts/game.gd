extends Node2D

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


func _ready():
	if gamemode.BUMPERS.is_current_gamemode():
		$background/bumpers.show()

	#if we restart the game, reset the score
	score_controller.reset()

	color.randomizer([background, [$enemies.get_children(), $color_holder/enemies], [ctrl_area, play_area, $hud.get_children()], [$player.get_node('sprite'), $color_holder/player]])
	score_controller.connect('score_changed', self, "enemies_colliding")
	for enemy in get_tree().get_nodes_in_group('enemy'):
		enemy.connect('hit', self, 'bump')


func _process(delta):
	finger = ctrl_area.get_local_mouse_position()

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
				if Input.is_action_just_pressed('press'):
					$player.position = play_area.to_global(Vector2(x, y))

			# BUMPERS mode code:
			gamemode.BUMPERS:
				move(15)


func move(speed):
	"""
	lerps (moves) the player to specified location
	args:
		speed:  a percentage of how far along the interpolation is.
	"""
	if has_node('player'):
		$player.position = $player.position.linear_interpolate(play_area.to_global(Vector2(x,y)), (get_process_delta_time() * speed))


func _on_gameover():
	progress.update_progress()
	level_manager.load_level(level_manager.menu_gameover)
	score_controller.gameover = false
	gamemode.current_gamemode.save_highscore()


var time = 0.05
var hits = 0
func enemies_colliding():
	"""
	makes the camera shake when enemies collide
	"""
	$camera.shake(3, 0.13, 0.0005)
	hits += 1
	time -= get_process_delta_time()
	if time <= 0 and hits >= 4 and $timer.time_left == 0:
		$camera.shake(hits, 0.13, 0.0006)
		time = 0.05
		hits = 0
	pass


func bump(enemy):
	"""
	makes the particle effect when enemies hit things
	args:
		enemy: the blocks that can kill you
	"""
	var p = preload('res://scenes/particles.tscn').instance()
	p.modulate = $color_holder/enemies.modulate
	p.position = enemy.position
	$enemies.add_child(p)
