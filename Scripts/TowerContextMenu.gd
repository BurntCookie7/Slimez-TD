extends Control
@export var sell_price: int = 9

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sell_button_pressed() -> void:
	Globals.gold += sell_price
	owner.queue_free()


func _on_exit_pressed() -> void:
	hide()
