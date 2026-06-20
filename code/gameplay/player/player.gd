class_name Player extends Pushable

#var bullet_scene = preload("res://scenes/player/basic_bullet.tscn")
var acceleration = 1000.0
var max_speed = 1500.0
var can_shoot = false

func attack():
	var attack = Attack.new()
	attack.damage = 2
	return attack

func _physics_process(delta:float):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction:
		move_velocity = move_velocity.move_toward(input_direction * max_speed, acceleration * delta)
	else:
		move_velocity = move_velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_knockback(delta)
	#print(velocity)
	
	#if Input.is_action_just_pressed("shoot") and can_shoot:
		#var mouse_angle = get_viewport().get_mouse_position() - position
		#var bullet = bullet_scene.instantiate()
		#bullet.attack = attack()
		#bullet.position = global_position
		#bullet.speed = 180
		#bullet.angle = mouse_angle.normalized()
		#bullet.rotation = mouse_angle.angle()
		##bullet.timer.wait_time = 1
		#owner.add_child(bullet)
