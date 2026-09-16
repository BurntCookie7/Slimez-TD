extends Node2D
@onready var path: PathFollow2D = $Path2D/PathFollow2D

@export var enemies: Array[PackedScene]
@onready var path_node = find_child("Path2D", true, false)
@onready var active_followers: Array[PathFollow2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy(enemies[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for follower in active_followers:
		follower.progress += 0.5
	

func spawn_enemy(enemy_choice: PackedScene):
	var follower := PathFollow2D.new()
	path_node.add_child(follower)
	var enemy_instance = enemy_choice.instantiate()
	follower.add_child(enemy_instance)
	active_followers.append(follower)
	
func _on_timer_timeout():
	spawn_enemy(enemies[0])
