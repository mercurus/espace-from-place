extends Control
@onready var player = $"../../../World/EntityRoot/Player"
@onready var xt_bar = $ProgressBar
@onready var xt_label = $ProgressBar/Label
@onready var prog_bar = $ProgressBar

var xt_max: int
var xt_current: int

func _ready() -> void:
	xt_max = player.xt_max
	xt_current = player.xt_current
		
	xt_bar.max_value = xt_max
	xt_bar.value = xt_current
	
	prog_bar.value = xt_current
	
	xt_label.text = "%s / %s" % [xt_current, xt_max]


func _on_player_change_xt(new_value) -> void:
	xt_current = new_value
	xt_label.text = "%s / %s" % [xt_current, xt_max]
	prog_bar.value = xt_current
