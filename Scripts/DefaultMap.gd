extends Node2D
@onready var path: PathFollow2D = $Path2D/PathFollow2D


@export var enemies: Array[PackedScene]
@export var number_of_enemies: int
@export var enemy_spawn_rate: float
@onready var path_node = find_child("Path2D", true, false)
@onready var tilemap = find_child("TileMapLayer")
@onready var active_followers: Array[PathFollow2D] = []
var enemies_spawned: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for follower in active_followers:
		follower.progress += follower.get_meta("Speed") * 2
	manage_enemies()
	
func spawn_enemy(enemy_choice: PackedScene):
	if enemies_spawned >= number_of_enemies:
		pass
	else:
		var follower := PathFollow2D.new()
		path_node.add_child(follower)
		follower.rotates = false
		follower.loop = false
		var enemy_instance = enemy_choice.instantiate()
		follower.set_meta("Speed", enemy_instance.get_meta("Speed"))
		follower.add_child(enemy_instance)
		active_followers.append(follower)
		enemies_spawned += 1
		
func _on_timer_timeout():
	var enemy_index = randi_range(0, 1)
	spawn_enemy(enemies[enemy_index])
	
func manage_enemies():
	for i in range(active_followers.size() - 1, -1, -1):
		var follower = active_followers[i]
		
		if follower.progress_ratio >= 1.0:
			follower.queue_free()
			path_node.remove_child(follower)
			active_followers.remove_at(i)
			continue
			
