extends StaticBody2D

@export var attack_range: float = 0.5
@onready var radius: Area2D = $Radius
@onready var radius_display: Sprite2D = $RadiusDisplay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radius.scale = Vector2 (attack_range, attack_range)
	radius_display.scale = Vector2 (attack_range, attack_range)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
