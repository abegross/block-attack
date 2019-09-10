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

func _process(delta: float) -> void:
	var spectrum = AudioServer.get_bus_effect_instance(0,1)
#	print(spectrum)
	var magnitude = spectrum.get_magnitude_for_frequency_range(20,100)
	print(magnitude)
	$sprite.scale = Vector2(clamp(magnitude.x * 30,1.5,1.7),clamp(magnitude.y * 30,1.5,1.7))

func _on_enemy_body_entered(body):
	score_controller.score_a_point()
	emit_signal('hit', self)
