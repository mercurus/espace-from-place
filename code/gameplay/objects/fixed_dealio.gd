extends Pushable


func _physics_process(delta:float):
	knockback_velocity = Vector2.ZERO
	move_and_knockback(delta)
