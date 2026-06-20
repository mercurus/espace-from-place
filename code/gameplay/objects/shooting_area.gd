extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var shape = $CenterContainer/ColorRect
@onready var collision = $CollisionShape2D
var shrink_speed = 0

func _process(delta):
	if shrink_speed == 0:
		return
	
	var shrink_vector = Vector2(1, 1) * (shrink_speed * delta)
	# gotta stop it from complaining about having a negative size...
	if shape.custom_minimum_size.x - shrink_vector.x < 0 \
	or shape.custom_minimum_size.y - shrink_vector.y < 0:
		shape.custom_minimum_size = Vector2(0, 0)
	else:
		shape.custom_minimum_size -= shrink_vector
	collision.shape.size = shape.custom_minimum_size
	# the rectangle has a centered anchor while the collision box has a top-left anchor
	collision.position = shape.position + (collision.shape.size * Vector2(0.5, 0.5))
	if shape.custom_minimum_size.x <= 0 or shape.custom_minimum_size.y <= 0:
		queue_free()
		try_disable_shoot()

func _on_body_entered(body):
	if !body.is_in_group("player"):
		return
	player.can_shoot = true

func _on_body_exited(body):
	if !body.is_in_group("player"):
		return
	try_disable_shoot()

func _on_timer_timeout():
	shrink_speed = 50

func try_disable_shoot():
	# this is necessary in case there are overlapping shooting_areas
	# and you're in the overlap while one shrinks away, making you exit it
	# while you're still in another valid area
	var can_still_shoot = false
	for area in get_tree().get_nodes_in_group("shooting_area"):
		if area.overlaps_body(player):
			can_still_shoot = true
			break
	player.can_shoot = can_still_shoot
