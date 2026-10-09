extends CharacterBody2D

@onready var health_system: HealthSystem = $HealthSystem
var tower = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		health_system.lose_health(body.damage)
		body.active = false
		body.queue_free()
		
func _physics_process(delta: float) -> void:
	if health_system.health <= 0:
		health_system.die(true)
		
