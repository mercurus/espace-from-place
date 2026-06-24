extends Control
@onready var player = $"../../../World/EntityRoot/Player"
@onready var xt_label = $Label
@onready var charge_bar = $ProgressBar
@onready var excess_bar = $ProgressBar2

var xt_max: int
var xt_current: int
var xt_excess_threshold: int

func _ready() -> void:
	xt_max = player.xt_max
	xt_current = player.xt_current
	xt_excess_threshold = player.xt_max_zone_charge
	
	charge_bar.max_value = xt_max
	excess_bar.max_value = xt_max

	xt_label.text = "%s / %s" % [xt_current, xt_max]


func _on_player_change_xt(new_value) -> void:
	xt_current = new_value
	excess_bar.value = xt_current
	if xt_current < xt_excess_threshold:
		charge_bar.value = xt_current
	
	xt_label.text = "%s / %s" % [xt_current, xt_max]
