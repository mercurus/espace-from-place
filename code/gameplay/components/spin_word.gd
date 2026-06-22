@tool
extends RichTextEffect
class_name RichTextSpin

# Name of the BBCode tag you will use in the label
var bbcode = "spin"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	# Get the speed parameter, default to 2.0
	var speed = char_fx.env.get("speed", 1.0)
	
	# Calculate full 360-degree rotation (2 * PI radians)
	var angle = char_fx.elapsed_time * speed * (2 * PI)
	
	# Construct the rotation matrix (Transform2D)
	var t = Transform2D()
	t = t.rotated(angle)
	
	# Apply rotation to the character's transform
	char_fx.transform = char_fx.transform * t
	
	return true
