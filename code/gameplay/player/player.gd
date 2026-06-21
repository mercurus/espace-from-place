class_name Player extends Pushable

#var bullet_scene = preload("res://scenes/player/basic_bullet.tscn")
var acceleration = 1000.0
var max_speed = 1500.0
var can_shoot = false

var in_nether_zone: bool = false

var geyser_pg_count: int = 2

var xt_cell_count: int = 5
signal change_xt

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
	
	if (Input.is_action_just_pressed("drop_xt_cell")):
		drop_xt_cell()
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



func drop_xt_cell():
	#if in_nether_zone:
	if xt_cell_count > 0 and in_nether_zone:
		xt_cell_count -= 1
		emit_signal("change_xt", 100)




func _on_cspg_area_entered(area: Area2D) -> void:
	in_nether_zone = true


func _on_cspg_area_exited(area: Area2D) -> void:
	in_nether_zone = false
