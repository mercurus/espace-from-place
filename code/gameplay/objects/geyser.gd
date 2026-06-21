extends Area2D

@export var debug: bool
@export var gas_remaining: float

var has_geyser_pg: bool

func _ready() -> void:
	erupt_geyser()
	

#Conncet to geyser pg
func change_gas_remaining(amount):
	gas_remaining -= amount
	if debug:
		print("Geyser %s gas remaining: %s" % [self, gas_remaining])


#Connect to away ship
func _on_geyser_build_area_entered(area: Area2D) -> void:
	if debug:
		print("Geyser build area entered: %s" % area)

#Connect to away ship
func _on_geyser_build_area_exited(area: Area2D) -> void:
	if debug:
		print("Geyser build area exited: %s" % area)

func erupt_geyser():
	
	if debug:
		print("Geyser %s has erupted" % self)
