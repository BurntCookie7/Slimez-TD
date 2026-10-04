extends Sprite2D



var target = Vector2(528, 436)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.lerp(target, 1.2 * delta)
