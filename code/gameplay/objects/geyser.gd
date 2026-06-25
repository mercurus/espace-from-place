extends Area2D

@export var debug: bool
@export var gas_remaining: float

signal geyser_discovery_entered

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player":
		emit_signal("geyser_discovery_entered")
