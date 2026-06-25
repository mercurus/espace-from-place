extends Label

func write_stuff(stuff):
	self.visible = true
	self.text = stuff
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 1)
	tween.tween_interval(3.0)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.1)
	await tween.finished
	self.visible = false
	
