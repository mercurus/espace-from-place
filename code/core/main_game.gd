class_name MainGame extends Node
## Main entry point for the game
## Responsible for coordination, not micro-managing

const PLAYER_SCENE_UID:String = "uid://coho61s7devlj"

@onready var level_root:Node2D = $World/LevelRoot
@onready var entity_root:Node2D = $World/EntityRoot
@onready var effect_root:Node2D = $World/EffectRoot

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player_scene:PackedScene = ResourceLoader.load(PLAYER_SCENE_UID) as PackedScene
	#if player_scene == null:
		#push_error("Could not load player scene")
		#return
	#
	#player = player_scene.instantiate()
	#if player == null:
		#push_error("Error loading player scene " + PLAYER_SCENE_UID)
		#return
	#
	#entity_root.add_child(player)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
