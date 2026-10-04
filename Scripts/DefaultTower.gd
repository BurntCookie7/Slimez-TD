extends StaticBody2D

@export var attack_range: float = 0.5
@onready var radius: Area2D = $AttackBounds
@onready var radius_display: Sprite2D = $RadiusDisplay
@export var projectile: PackedScene
@export var projectile_speed: float
var projectile_instance = null
var target_enemy
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
		shoot()
		
		
		
func shoot():
	if projectile_instance == null:
		projectile_instance = projectile.instantiate()
		add_child(projectile_instance)
		projectile_instance.active = true
	
func manage_projectile():
	if projectile_instance != null:
		if projectile_instance.active == true:
			projectile_instance.global_position.x = move_toward(projectile_instance.global_position.x, target_enemy.global_position.x, projectile_speed)
			projectile_instance.global_position.y = move_toward(projectile_instance.global_position.y, target_enemy.global_position.y, projectile_speed)
	else:
		projectile_instance = null
