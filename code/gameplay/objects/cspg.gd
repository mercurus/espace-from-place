extends Area2D

#Temporarily calling the free energy field surrounding the CSPG the power field
#Temporarily calling fuel resource XT

@onready var power_field = $PowerField.shape

signal xt_changed
signal power_field_changed
signal power_field_entered
signal power_field_exited

@export var debug: bool
@export var current_xt: float
@export var max_xt: int
@export var power_field_size: float
var is_power_field_active: bool = true

func _ready() -> void:
	change_power_field_size(power_field_size)

func _draw() -> void:
	power_field.draw(get_canvas_item(), Color(0, 1, 1, 0.35))


# power Field
func change_power_field_size(new_value):
	power_field.radius = new_value
	emit_signal("power_field_changed")

#connect away ship to this method
func _on_power_field_entered(area: Area2D) -> void:
	emit_signal("power_field_entered")
	if debug:
		print("power field entered: %s" % area)

#connect away ship to this method
func _on_power_field_exited(area: Area2D) -> void:
	emit_signal("power_field_exited")
	if debug:
		print("power field exited: %s" % area)

# XT
func change_xt_value(value):
	current_xt += value
	emit_signal("xt_changed", current_xt)
	if debug:
		print("XT new value: %s" % current_xt)


func _on_player_change_xt(value) -> void:
	change_xt_value(value)


func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player" and is_power_field_active:
		emit_signal("power_field_entered")

func _on_body_exited(body: Node2D) -> void:
	if body.get_name() == "Player" and is_power_field_active:
		emit_signal("power_field_exited")
