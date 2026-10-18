extends StaticBody2D

@export_group("Upgradables")
@export var attack_range: float = 0.5
@export var projectile_speed: float = 5.0
@export var projectile_damage: int = 50.0
@export var cooldown_: float
@export_group("")
@onready var radius: Area2D = $AttackBounds
@onready var radius_display: Sprite2D = $RadiusDisplay
#@onready var context_menu: Control = $ContextMenu
@export var projectile: PackedScene
@export var max_targets: int = 1


var overlapping_bodies: Array[Node2D] = []
var projectile_instance = null
var target_enemy = null
var overlap: bool
var targets: Array[Node2D]
var active_projectiles: Array[Dictionary]
var upgradables := [
	{"name": "Damage", "cost": 50, "level": 0, "max_level": 5},
	{"name": "Range",  "cost": 75, "level": 0, "max_level": 3},
]
var upgrade_steps = {
	"attack_range": 0,
	"projectile_speed": 0,
	"projectile_damage": 0,
}

var upgrade_prices = {
	"attack_range": 5,
	"projectile_speed": 5,
	"projectile_damage": 5,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	manage_projectile()
	if is_instance_valid(target_enemy):
		look_at(target_enemy.global_position)
	radius.scale = Vector2 (attack_range, attack_range)
	radius_display.scale = Vector2 (attack_range, attack_range)
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if is_in_group("Placed"):
		if event is InputEventMouseButton and event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				Globals.tower_selected.emit(self)
				radius_display.show()
				viewport.set_input_as_handled()

func is_overlapping() -> bool:
	return not overlapping_bodies.is_empty()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_in_group("Placing") and body.is_in_group("Placed"):
		if body not in overlapping_bodies:
			overlapping_bodies.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_in_group("Placing") and body.is_in_group("Placed"):
		overlapping_bodies.erase(body)


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
	projectile_instance.speed = projectile_speed
	projectile_instance.damage = projectile_damage
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
	
func get_upgradables() -> Array:
	var result := []
	var in_group := false
	for p in get_property_list():
		if p.usage & PROPERTY_USAGE_GROUP:
			in_group = (p.name == "Upgradables")
		elif in_group:
			result.append(p.name)
	return result
