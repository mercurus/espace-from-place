extends Camera2D

const MAX_DISTANCE_VECTOR := Vector2(40.0, 40.0)
var target_distance := 0.0
var center_position = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = center_position.direction_to(get_local_mouse_position())
	var target_position = center_position + direction * target_distance
	
	position = target_position.clamp(
		center_position - MAX_DISTANCE_VECTOR,
		center_position + MAX_DISTANCE_VECTOR
	)

func _input(event):
	if event is InputEventMouseMotion:
		target_distance = center_position.distance_to(get_local_mouse_position()) * 0.5
