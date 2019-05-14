extends RigidBody2D

signal hit

var speed = 700

func _ready():
	if gamemode.INTANGIBLE.is_current_gamemode():
		# 1 is the enemy. not sure why i cant use the name i gave it
		set_collision_mask_bit(1, false)
	if gamemode.BUMPERS.is_current_gamemode():
		speed = 400

	randomize()
	apply_impulse(Vector2(),Vector2(speed, 0).rotated(rand_range(0*PI, 2*PI)))

	Engine.time_scale = 0

func _on_enemy_body_entered(body):
	score_controller.score_a_point()
	emit_signal('hit', self)