extends Panel

@onready var robot = preload("res://assets/images/sprites/wingbot1.png")
@onready var soldier = preload("res://assets/images/sprites/soldier.png")
@onready var key_t = preload("res://assets/images/input icons/keyboard_t.png")
@onready var key_wasd = preload("res://assets/images/input icons/keyboard_arrows.png")
@onready var dialogue_char = self.get_child(0).get_child(0).get_child(0)
@onready var text_box = self.get_child(0).get_child(1)
@onready var dialogue_icon = self.get_child(0).get_child(2)

var di = 0
var game_start: Array
var geyser_discovery: Array
var current_dialogue
var in_dialogue: bool

func _ready() -> void:
	#dialogue [ character texture, dialogue text, icon (if necessary), dialogue completed bool)
	game_start = \
	[ [soldier, "What just happened? [wave]Where are we?[/wave]", key_t, false], \
	[robot, "Whoa dude you just landed on [spin]S[/spin]pintera!", null],\
	[robot, "The ship's reactor is totally depleted from the anomaly.\nOur only way out of here is to recharge it.", null], \
	[robot, "Use WASD to maneuver the hover craft. Explore the area to gather resources and charge the ship.", key_wasd], \
	[robot, "Act quickly, a huge storm is on the way.\nYou have about 15 minutes.", null] ]
	
	geyser_discovery = \
	[ [robot, "We could generate energy using that [wave]geyser[/wave].\nI'll make a turbine using spare parts.", null, false], \
	[robot, "Come back to the ship and I'll give you one.", null] ]
	start_dialogue(game_start)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("alt_action") and in_dialogue:
		if di == get_dialogue().size() - 1:
			end_dialogue()
		else:
			di += 1
			advance_dialogue(get_dialogue())

func get_dialogue():
	return current_dialogue

func start_dialogue(plot):
	self.visible = true
	in_dialogue = true
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
	in_dialogue = false
	get_dialogue()[0][3] = true
	di = 0
	print(di)

func _on_geyser_discovery():
	if in_dialogue == false and geyser_discovery[0][3] == false:
		start_dialogue(geyser_discovery)
