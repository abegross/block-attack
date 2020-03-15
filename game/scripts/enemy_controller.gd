extends RigidBody2D

signal hit

var speed = 700

func _ready():
	if gamemode.INTANGIBLE.is_current_gamemode():
		# 1 is the enemy. not sure why i cant use the name i gave it
		set_collision_mask_bit(1, false)
	if gamemode.BUMPERS.is_current_gamemode():
		speed = 500

	randomize()
	apply_impulse(Vector2(),Vector2(speed, 0).rotated(rand_range(0*PI, 2*PI)))

	Engine.time_scale = 0

##var biggestx=0
##var biggesty=0
##var smallestx=INF
##var smallesty=INF
##func _process(delta: float) -> void:
##	update()
##var WIDTH = 1000
##var HEIGHT = 200
##var VU_COUNT = 16
##var FREQ_MAX = 1000
#var MIN_DB= 80
#func _draw() -> void:
#	var spectrum = AudioServer.get_bus_effect_instance(0,1)
#
##	var w = WIDTH / VU_COUNT
##	var prev_hz = 0
##	for i in range(1,VU_COUNT+1):
##		var hz = i * FREQ_MAX / VU_COUNT;
##		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
##		var energy = clamp((MIN_DB + linear2db(f.length()))/MIN_DB,0,1)
##		var height = energy * HEIGHT
##		draw_rect(Rect2(w*i,HEIGHT-height+200,w,height),Color(1,1,1))
##		prev_hz = hz
#
##	print(spectrum)
#	var magnitude = spectrum.get_magnitude_for_frequency_range(43,86)
#	var energy = (MIN_DB + linear2db(magnitude.length()))/MIN_DB
##	var height = energy * 40
#	#(max'-min')/(max-min)*(value-min)+min'
##	energy = (1.7-1.5)/(-6-mnm)*(energy-mnm)+1.5
#	# o = old
#	var omax = 0.95
#	var omin = 0.85
#	# n = new
#	var nmax = 1.8
#	var nmin = 1.5
##	(((value-omin)*(nmax-nmin))/(omax-omin))+nmin
##	draw_string(preload("res://fonts/bocvi.tres"), Vector2(0,800), str(energy), Color.red)
#	energy = (((energy-omin)*(nmax-nmin))/(omax-omin))+nmin
##	draw_string(preload("res://fonts/bocvi.tres"), Vector2(0,900), str(energy), Color.red)
#	energy = clamp(energy, nmin, nmax)
##	draw_string(preload("res://fonts/bocvi.tres"), Vector2(0,1000), str(energy), Color.red)
##	energy = (((mxm-mnm)*(1.7-1.5)) / (energy-1.5)) + mnm
##	draw_rect(Rect2(0,1080,50,energy*100),Color.red)
##	print(energy)
##	if biggestx < magnitude.x:
##		biggestx = magnitude.x
##	if biggesty < magnitude.y:
##		biggesty = magnitude.y
##	if smallestx > magnitude.x:
##		smallestx = magnitude.x
##	if smallesty > magnitude.y:
##		smallesty = magnitude.y
##	print(Vector2(biggestx,biggesty), Vector2(smallestx, smallesty))
#	resize_enemy(energy)
#
#func resize_enemy(size):
#	$sprite.scale = Vector2(size,size)#clamp(magnitude.y * 30,1.5,1.7),clamp(magnitude.y * 30,1.5,1.7))#clamp(magnitude.x * 30,1.5,1.7),clamp(magnitude.y * 30,1.5,1.7))


func _on_enemy_body_entered(body):
	score_controller.score_a_point()
	emit_signal('hit', self)
#func Print():
#	$timer.wait_time=0.5
#	$timer.start()