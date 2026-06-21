extends Area2D

@onready var progress_bar = $ColorRect/ProgressBar
@onready var xt_tick = $XtTick
@onready var xt_tooltip = $Panel

@export var hp: int
@export var max_battery_charge: int
@export var deploy_ramp_time: float

@export var xt_tick_charge_amount: int
@export var xt_tick_time: float

var battery_charge_count: int = 0
var is_deployed: bool = false


func _ready() -> void:
	deploy_geyser_pg()
	
func deploy_geyser_pg():
	var tween = create_tween()
		
	progress_bar.visible = true
	tween.tween_property(progress_bar, "value", 100, 1.0)
	await tween.finished
	is_deployed = true
	progress_bar.visible = false
	xt_tick.start(xt_tick_time)

func charge_battery():
	battery_charge_count += xt_tick_charge_amount


func _on_mouse_entered() -> void:
	if is_deployed:
		$Panel.visible = true



func _on_mouse_exited() -> void:
	if is_deployed:	
		$Panel.visible = false
