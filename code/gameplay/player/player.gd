class_name Player extends CharacterBody2D

#var bullet_scene = preload("res://scenes/player/basic_bullet.tscn")
var acceleration = 600.0
var max_speed = 1200.0
var friction = 800.0
var can_shoot = false

func attack():
	var attack = Attack.new()
	attack.damage = 2
	return attack

func _physics_process(delta:float):
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
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction:
		velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("apply_knockback"):
			var push_dir = -collision.get_normal()
			collider.apply_knockback(push_dir, velocity.length())
			print(velocity.length())
	#print(velocity)
