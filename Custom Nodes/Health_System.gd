@icon("res://addons/at-icons/node/heart.svg")
class_name HealthSystem
extends Node

@export var max_health: float = 100.0
@export var min_health: float = 0.0
var health: float = 100
@onready var host = owner
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.

func lose_health(ammount: float):
	health -= ammount

func die():
	owner.queue_free()
