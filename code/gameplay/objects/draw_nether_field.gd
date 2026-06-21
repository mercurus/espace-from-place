extends CollisionShape2D

func _draw() -> void:
	if shape:
		shape.draw(get_canvas_item(), Color(1, 0, 1, 0.5))
