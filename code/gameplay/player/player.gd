class_name Player extends Pushable

#var bullet_scene = preload("res://scenes/player/basic_bullet.tscn")
var acceleration = 1000.0
var max_speed = 1500.0
var can_shoot = false

@onready var ship_sprite = $Ship

@export var xt_max: float
@export var xt_max_zone_charge: float
@export var xt_charge_amount: float
@export var xt_charge_rate: float
@export var xt_current: float = 200
var xt_expend_amount: float = 0.25

var in_power_zone: bool = false
var geyser_pg_count: int = 1
signal change_xt
signal fuel_empty

func attack():
	var attack = Attack.new()
	attack.damage = 2
	return attack

func _process(delta: float) -> void:
	if xt_current <= 0:
		you_died("YOU RAN OUT OF ENERGY")

func _physics_process(delta:float):
	if xt_current > 0:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if input_direction:
			move_velocity = move_velocity.move_toward(input_direction * max_speed, acceleration * delta)
			if in_power_zone == false:
				xt_current -= xt_expend_amount
				emit_signal("change_xt", xt_current)
		else:
			move_velocity = move_velocity.move_toward(Vector2.ZERO, friction * delta)
			if in_power_zone == false:
				xt_current -= xt_expend_amount
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
	
	ship_sprite.rotate(.01)

func xt_charge_in_zone():
	if xt_current < xt_max_zone_charge:
		xt_current += xt_charge_amount
		emit_signal("change_xt", xt_current)

func _on_enter_power_field():
	in_power_zone = true

func _on_exit_power_field():
	in_power_zone = false

func you_died(label_text):
	emit_signal("fuel_empty", label_text)
	self.position = ($"../CSPG".position)
