class_name Pushable extends CharacterBody2D

var knockback_velocity := Vector2.ZERO
@export var knockback_friction := 800.0

func _ready() -> void:
	pass

func _physics_process(delta):
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta)
	velocity = knockback_velocity
	move_and_slide()

func apply_knockback(direction: Vector2, force: float):
	knockback_velocity = direction * force
