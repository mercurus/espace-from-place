class_name Player2 extends Pushable

#var bullet_scene = preload("res://scenes/player/basic_bullet.tscn")
var acceleration = 800.0
var max_speed = 600.0
var can_shoot = false

@onready var ship_sprite = $Ship
@export var xt_max: float
@export var xt_max_zone_charge: float
@export var xt_charge_amount: float
@export var xt_charge_rate: float
var xt_current: float = 200
var xt_expend_amount: float = 0.25
@onready var collision_shape = $CollisionShape2D
var in_power_zone: bool = false
var geyser_pg_count: int = 1
signal change_xt


func _physics_process(delta:float):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction:
		move_velocity = move_velocity.move_toward(input_direction * max_speed, acceleration * delta)
		ship_sprite.rotation = rotate_toward(ship_sprite.rotation, input_direction.angle(), delta * 4)
		collision_shape.rotation = ship_sprite.rotation + (PI * 0.5) # capsule shape needs to match oval ship
	else:
		move_velocity = move_velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if xt_current > 0:
		if in_power_zone == false:
			#xt_current -= xt_expend_amount
			emit_signal("change_xt", xt_current)
		move_and_knockback(delta)
	
	if in_power_zone:
		xt_charge_in_zone()
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
	
	#ship_sprite.rotate(.01)

func xt_charge_in_zone():
	#if xt_current < xt_max_zone_charge:
	xt_current += xt_charge_amount
	emit_signal("change_xt", xt_current)


func _on_cspg_body_entered(body: Node2D) -> void:
	if body.is_in_group("Power Zone"):
		in_power_zone = true

func _on_cspg_body_exited(body: Node2D) -> void:
	if body.is_in_group("Power Zone"):
		in_power_zone = false
