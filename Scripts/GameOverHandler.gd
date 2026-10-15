extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 500
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_retry_pressed() -> void:
	get_tree().paused = false
	Globals.gold = Globals.default_gold
	Globals.round = 0
	Globals.round_active = false
	Globals.player_health = Globals.default_player_health
	Globals.paused = false
	get_tree().reload_current_scene()
	queue_free()
