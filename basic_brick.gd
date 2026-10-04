extends CharacterBody2D
@onready var health: HealthSystem = $HealthSystem


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		health.lose_health(body.damage)
		body.active = false
		body.queue_free()
