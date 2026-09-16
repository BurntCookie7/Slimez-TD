extends Node

@export var Map1: PackedScene
@export var Map2: PackedScene


var current_map = Map1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Map_Instance = Map2.instantiate()
	current_map = Map_Instance
	add_child(Map_Instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_map(map_choice: PackedScene):
	current_map.queue_free()
	var Map_Instance = map_choice.instantiate()
	current_map = Map_Instance
	add_child(Map_Instance)
