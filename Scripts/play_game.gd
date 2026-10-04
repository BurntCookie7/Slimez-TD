extends Button
var default_scale = scale


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://RootScene.res")


func _on_mouse_entered() -> void:
	scale.x = scale.x+0.01
	scale.y = scale.x+0.01


func _on_mouse_exited() -> void:
	scale.x = default_scale.x
	scale.y = default_scale.y
