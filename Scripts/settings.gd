extends Button
var default_scale = scale
@export var settings_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var settings_instance = settings_scene.instantiate()
	owner.add_child(settings_instance)
	owner.move_child(settings_instance, -1)

func _on_mouse_entered() -> void:
	scale.x = scale.x+0.03
	scale.y = scale.x+0.03


func _on_mouse_exited() -> void:
	scale.x = default_scale.x
	scale.y = default_scale.y
