extends Panel

@onready var robot = preload("uid://b3a4dkyvccm6l")
@onready var dialogue_char = self.get_child(0).get_child(0).get_child(0)
@onready var keyboard_icon = self.get_child(0).get_child(1).get_child(0)

var dialogue_01: Array[String] = ["Whoa dude you just crash landed on [spin]S[/spin]pintera!"]

func _ready() -> void:
	start_dialogue(robot, dialogue_01)

func start_dialogue(char, plot):
	char.texture = char
