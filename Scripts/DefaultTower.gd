extends StaticBody2D

@export var attack_range: float = 0.5
@onready var radius: Area2D = $AttackBounds
@onready var radius_display: Sprite2D = $RadiusDisplay
@export var projectile: PackedScene
@onready var projectile_speed: float
var projectile_instance = null
var target_enemy = null
var overlap: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radius.scale = Vector2 (attack_range, attack_range)
	radius_display.scale = Vector2 (attack_range, attack_range)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	manage_projectile()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_in_group("Placing") and body.is_in_group("Placed"):
		overlap = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_in_group("Placing") and body.is_in_group("Placed"):
		overlap = false


func _on_attack_bounds_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") and is_in_group("Placed"):
		target_enemy = body

func _on_attack_bounds_body_exited(body: Node2D) -> void:
	if body == target_enemy:
		target_enemy = null


func shoot() -> void:
	if is_instance_valid(projectile_instance) or not is_instance_valid(target_enemy):
		return
	projectile_instance = projectile.instantiate()
	add_child(projectile_instance)
	projectile_speed = projectile_instance.speed
	projectile_instance.active = true
		
	
func manage_projectile() -> void:
	# Projectile was freed (hit something): clear it and fire again if we can
	if not is_instance_valid(projectile_instance):
		projectile_instance = null
		if not is_instance_valid(target_enemy):
			target_enemy = _find_new_target()
		shoot()
		return

	# Target died or left while the projectile was mid-flight
	if not is_instance_valid(target_enemy):
		projectile_instance.queue_free()
		projectile_instance = null
		target_enemy = _find_new_target()
		return

	if projectile_instance.active:
		projectile_instance.global_position = projectile_instance.global_position.move_toward(
			target_enemy.global_position, projectile_speed)
		
func _find_new_target() -> Node2D:
	if not is_in_group("Placed"):
		return null
	for body in radius.get_overlapping_bodies():
		if is_instance_valid(body) and body.is_in_group("Enemy"):
			return body
	return null
