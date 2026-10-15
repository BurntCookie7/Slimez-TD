extends Node2D
@export var game_over_scene: PackedScene
@export var default_player_health: int = 100
@export var default_gold: int = 30
var game_over_instance = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_instance = null
	Globals.default_gold = default_gold
	Globals.default_player_health = default_player_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Globals.player_health <= 0 and not is_instance_valid(game_over_instance):
		game_over_instance = game_over_scene.instantiate()
		add_child(game_over_instance)
		move_child(game_over_instance, 0)
		
