class_name Pushable extends CharacterBody2D

var knockback_velocity := Vector2.ZERO
var move_velocity := Vector2.ZERO
@export var knockback_friction := 800.0
@export var knockback_force := 20.0
@export var friction := 800.0
@onready var sprite = $Sprite2D

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(delta:float):
	move_and_knockback(delta)
	move_velocity = move_velocity.move_toward(Vector2.ZERO, friction * delta)
	if velocity.length() > 0:
		sprite.rotate((velocity.length() / 500) * PI * 0.05)

func move_and_knockback(delta:float):
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta)
	velocity = move_velocity + knockback_velocity
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		var collision_normal = collision.get_normal()
		var dot = velocity.dot(collision_normal)
		if dot < 0:
			move_velocity -= collision_normal * dot
			move_velocity *= 0.3
			#velocity = Vector2.ZERO
		
		if collider.has_method("apply_knockback"):
			collider.apply_knockback(-collision_normal, velocity.length() + knockback_force)
		
		
func apply_knockback(direction:Vector2, force:float):
	knockback_velocity = direction * force
