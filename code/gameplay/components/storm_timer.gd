extends Label

var time_remaining: int = 914

func _ready() -> void:
	update_timer_label(time_remaining)

func _on_timer_timeout() -> void:
	time_remaining -= 1
	update_timer_label(time_remaining)

func update_timer_label(time_left: float) -> void:
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	self.text = "Storm in %02d:%02d" % [minutes, seconds]
