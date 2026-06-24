extends Area2D

#Temporarily calling the free energy field surrounding the CSPG the nether field
#Temporarily calling fuel resource XT

@onready var nether_field = $"Nether Field".shape

signal xt_changed
signal nether_field_changed
signal nether_field_entered
signal nether_field_exited

@export var debug: bool
@export var current_xt: float
@export var max_xt: int
@export var nether_field_size: float

func _ready() -> void:
	change_nether_field_size(nether_field_size)

# Nether Field
func change_nether_field_size(new_value):
	nether_field.radius = new_value
	emit_signal("nether_field_changed")

#connect away ship to this method
func _on_nether_field_entered(area: Area2D) -> void:
	emit_signal("nether_field_entered")
	if debug:
		print("Nether field entered: %s" % area)

#connect away ship to this method
func _on_nether_field_exited(area: Area2D) -> void:
	emit_signal("nether_field_exited")
	if debug:
		print("Nether field exited: %s" % area)

# XT
func change_xt_value(value):
	current_xt += value
	emit_signal("xt_changed", current_xt)
	if debug:
		print("XT new value: %s" % current_xt)


func _on_player_change_xt(value) -> void:
	change_xt_value(value)
