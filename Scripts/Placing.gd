extends Node2D

@export var Tower: PackedScene
var current_tower = null
var tower_instance = null
@export var towers: Node
@export var map: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept") and not placing:
		#placing = true
	manage_placing()

func manage_placing():
	if Globals.placing:
		if is_instance_valid(tower_instance):
			var overlapped = tower_instance.is_overlapping()
			if overlapped:
				tower_instance.modulate = Color(1.0, 1.0, 1.0, 0.5)
			else:
				tower_instance.modulate = Color(1.0, 1.0, 1.0, 1.0)
			tower_instance.global_position = get_global_mouse_position()
			#tower_instance.add_to_group("Placing")
			tower_instance.radius_display.show()
			if Input.is_action_just_pressed("MouseLeft") and not overlapped:
				tower_instance.radius_display.hide()
				remove_child(tower_instance)
				tower_instance.global_position = get_global_mouse_position()
				towers.add_child(tower_instance)
				tower_instance.radius_display.hide()
				tower_instance.remove_from_group("Placing")
				tower_instance.add_to_group("Placed")
				Globals.placing = false
				tower_instance.input_pickable = true
		else:
			tower_instance.radius_display.hide()
			
func set_tower(tower):
	current_tower = tower
	tower_instance = current_tower.instantiate()
	tower_instance.add_to_group("Placing")
	add_child(tower_instance)
	
