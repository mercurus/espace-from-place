extends Area2D

@export var progress_bar: ProgressBar
@export var geyser_sprite: Sprite2D
@export var power_zone: CollisionShape2D
@onready var xt_tick = $XtTick
@onready var battery_tooltip = $Panel

@export var hp: int
@export var max_battery_charge: int
@export var deploy_ramp_time: float

@export var xt_tick_charge_amount: int
@export var xt_tick_rate: float

var is_power_field_active: bool = false
var battery_charge_amount: int = 0
var is_deployed: bool = false

signal power_field_entered
signal power_field_exited

func _ready() -> void:
	#deploy_geyser_pg()
	$Panel/Label.text = "Battery: %s" % battery_charge_amount

func _process(delta: float) -> void:
	if is_deployed:
		geyser_sprite.rotate(-0.03)

func _draw() -> void:
	if is_deployed:
		power_zone.shape.draw(get_canvas_item(), Color(1, 0, 1, 0.35))

func deploy_geyser_pg():
	var tween = create_tween()
	
	self.visible = true
	tween.tween_property(progress_bar, "value", 100, deploy_ramp_time)
	await tween.finished
	is_deployed = true
	progress_bar.visible = false
	xt_tick.start(xt_tick_rate)
	
	is_power_field_active = true
	power_zone.disabled = false
	is_power_field_active = true
	queue_redraw()

	


func charge_battery():
	battery_charge_amount += xt_tick_charge_amount
	if battery_charge_amount >= max_battery_charge:
		battery_charge_amount = max_battery_charge
	$Panel/Label.text = "Battery: %s" % battery_charge_amount
	charge_flash()
	
func charge_flash():
	var tween = create_tween()
	
	tween.tween_property(geyser_sprite, "modulate", Color(0.66, 0.66, 1.0, 1), 0.1)
	tween.tween_property(geyser_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
	
		
func _on_mouse_entered() -> void:
	if is_deployed:
		battery_tooltip.visible = true

func _on_mouse_exited() -> void:
	if is_deployed:	
		battery_tooltip.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player" and is_power_field_active:
		emit_signal("power_field_entered")

func _on_body_exited(body: Node2D) -> void:
	if body.get_name() == "Player" and is_power_field_active:
		emit_signal("power_field_exited")
