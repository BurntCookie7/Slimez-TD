extends Node2D
@onready var path: PathFollow2D = $Path2D/PathFollow2D

@export var enemies: Array[PackedScene]
@onready var path_node = find_child("Path2D", true, false)
@onready var path_follow = path_node.find_child("PathFollow2D", true, false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy(enemies[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += 0.5

func spawn_enemy(enemy_choice: PackedScene):
	var enemy_instance = enemy_choice.instantiate()
	path.add_child(enemy_instance)
