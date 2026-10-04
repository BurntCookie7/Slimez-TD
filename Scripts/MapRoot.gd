#Map.gd
#Every map in the game should use this script unless a map needs special features
@tool
extends Node

#@export var Map1: PackedScene
#@export var Map2: PackedScene
@onready var timer: Timer = $Timer
@export var Maps: Array[PackedScene]
var current_map = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_map(Maps[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		set_map(Maps[0])


func set_map(map_choice: PackedScene):
	if current_map != null:
		current_map.queue_free()
	var Map_Instance = map_choice.instantiate()
	current_map = Map_Instance
	add_child(Map_Instance)
	timer.timeout.connect(Map_Instance._on_timer_timeout)
