extends Node2D

@export var Towers: Array[PackedScene]
var placing: bool
var current_tower = null
var tower_instance = null
@onready var towers: Node = $"../Towers"
@onready var map: Node = $"../Map"
#var tilemap = map.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_tower(Towers[0])
	placing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		set_tower(Towers[0])
		placing = true
	manage_placing()

func manage_placing():
	if placing:
		tower_instance.global_position = get_global_mouse_position()
		tower_instance.radius_display.show()
		if Input.is_action_just_pressed("MouseLeft"):
			tower_instance.radius_display.hide()
			remove_child(tower_instance)
			tower_instance.global_position = get_global_mouse_position()
			towers.add_child(tower_instance)
			tower_instance.radius_display.hide()
			#tower_instance.queue_free()
			placing = false
	else:
		tower_instance.radius_display.hide()
		
func set_tower(tower):
	current_tower = tower
	tower_instance = current_tower.instantiate()
	add_child(tower_instance)
	
