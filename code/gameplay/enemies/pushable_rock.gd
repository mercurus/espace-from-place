extends Pushable

func _ready() -> void:
	sprite.frame = randi() % sprite.hframes
