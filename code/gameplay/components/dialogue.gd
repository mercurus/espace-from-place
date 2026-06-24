extends Panel

@onready var robot = preload("res://assets/images/sprites/wingbot1.png")
@onready var soldier = preload("res://assets/images/sprites/soldier.png")
@onready var key_t = preload("res://assets/images/input icons/keyboard_t.png")
@onready var key_wasd = preload("res://assets/images/input icons/keyboard_arrows.png")
@onready var dialogue_char = self.get_child(0).get_child(0).get_child(0)
@onready var text_box = self.get_child(0).get_child(1)
@onready var dialogue_icon = self.get_child(0).get_child(2)

var di = 0
var dialogue_01: Array
var current_dialogue

func _ready() -> void:
	#dialogue [ character texture, dialogue text, icon (if necessary), dialogue completed bool)
	dialogue_01 = [ [soldier, "Where... what just happened?", key_t], \
	[robot, "Whoa dude you just crash landed on [spin]S[/spin]pintera!", null],\
	[robot, "The ship's reactor is totally depleted from the anomaly.\nOur only way out of here is to recharge it.", null], \
	[robot, "Based on my calculations we need 10,000 XT to escape.", null] ]

	start_dialogue(dialogue_01)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("alt_action"):
		if di == get_dialogue().size() - 1:
			end_dialogue()
		else:
			di += 1
			advance_dialogue(get_dialogue())

func get_dialogue():
	return current_dialogue

func start_dialogue(plot):
	self.visible = true
	current_dialogue = plot
	dialogue_char.texture = plot[di][0]
	text_box.text = plot[di][1]
	dialogue_icon.texture = plot[di][2]

func advance_dialogue(plot):
	dialogue_char.texture = plot[di][0]
	text_box.text = plot[di][1]
	dialogue_icon.texture = plot[di][2]
		
func end_dialogue():
	self.visible = false
	di = 0
