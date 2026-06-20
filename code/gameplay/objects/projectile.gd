class_name Projectile extends CharacterBody2D

@onready var timer = $Timer
var attack:Attack
var angle:Vector2
var speed:float

#func _ready():
	

func _process(delta):
	position += angle * speed * delta

func _on_timer_timeout():
	queue_free()
