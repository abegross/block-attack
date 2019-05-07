extends RigidBody2D

	# if an enemy hits me
func _on_player_body_entered(body):
	print(body.name)
