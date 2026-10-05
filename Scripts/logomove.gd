extends Sprite2D



var target = Vector2(528, 436)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = lerp(target, global_position, exp(-1.5 * delta))
