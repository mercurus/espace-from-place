extends Label

func _ready() -> void:
	pass

func _on_cspg_xt_changed(new_value) -> void:
	self.text = "XT: %s" % str(int(new_value))
