extends Node2D
@export var settings_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func _on_settings_pressed() -> void:
	var settings_instance = settings_scene.instantiate()
	add_child(settings_instance)
	move_child(settings_instance, -1)
	
