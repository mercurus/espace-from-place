class_name HurtboxComponent extends Area2D

func _on_area_entered(area):
	if area is HitboxComponent:
		area.damage(get_parent().attack)
		get_parent().queue_free()
