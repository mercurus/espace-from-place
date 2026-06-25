extends CollisionShape2D

func _draw() -> void:
	if shape and get_parent().is_power_field_active:
		shape.draw(get_canvas_item(), Color(1, 0, 1, 0.35))
