extends Control
@export var level: PackedScene
#var level_path = null
func _ready() -> void:
	#level_path = level.resource_path
	pass

func _on_pressed() -> void:
	Globals.map = level
	get_tree().change_scene_to_file("res://RootScene.res")
