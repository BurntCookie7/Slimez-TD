extends Node
@onready var resolution: OptionButton = $"../NinePatchRect/Resolution/OptionButton"
@onready var selected_resolution = resolution.get_item_text(resolution.selected)
@onready var volume_number: Label = $"../NinePatchRect/Volume/Number"
@onready var volume_slider: HSlider = $"../NinePatchRect/Volume/HSlider"

const BASE_SIZE := Vector2i(1920, 1080)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _on_option_button_item_selected(index: int) -> void:
	selected_resolution = resolution.get_item_text(resolution.selected)
	var resolution_array = selected_resolution.split("x")
	var size = Vector2i(int(resolution_array[0]), int(resolution_array[1]))
	get_window().content_scale_size = size
	get_window().content_scale_factor = float(size.x) / BASE_SIZE.x
	#get_window().move_to_center()
	var cam := get_viewport().get_camera_2d()
	if cam:
		cam.zoom = Vector2(size) / Vector2(BASE_SIZE)


func _on_h_slider_value_changed(value: float) -> void:
	volume_number.text = str(int(volume_slider.value))
