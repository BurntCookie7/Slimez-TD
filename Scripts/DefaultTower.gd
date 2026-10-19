extends StaticBody2D

@export_group("Upgradables")
@export var attack_range: float = 0.5
@export var attack_cooldown: float = 1.0
@export var projectile_speed: float = 5.0
@export var projectile_damage: int = 50.0
@export_group("")
@onready var radius: Area2D = $AttackBounds
@onready var radius_display: Sprite2D = $RadiusDisplay
#@onready var context_menu: Control = $ContextMenu
@export var projectile: PackedScene
@export var max_targets: int = 1


var overlapping_bodies: Array[Node2D] = []
var overlap: bool
var targets: Array[Node2D]
var active_projectiles: Array[Dictionary]
var cooldown_remaining: float = 0.0

var upgrade_steps = {
	"attack_range": 0,
	"projectile_speed": 0,
	"projectile_damage": 0,
	"attack_cooldown": 0,
}

var upgrade_prices = {
	"attack_range": 5,
	"projectile_speed": 5,
	"projectile_damage": 5,
	"attack_cooldown": 5,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	radius.scale = Vector2 (attack_range, attack_range)
	radius_display.scale = Vector2 (attack_range, attack_range)
	
	remove_dead_enemies()
	update_shots()
	if targets.is_empty():
		return
		
	look_at(targets[0].global_position)
	
	cooldown_remaining -= delta
	if cooldown_remaining <= 0.0:
		fire_projectiles()
		cooldown_remaining = attack_cooldown
	
func remove_dead_enemies() -> void:
	for i in range(targets.size() - 1, -1, -1):
		if not is_instance_valid(targets[i]):
			targets.remove_at(i)

func fire_projectiles() -> void:
	var count := mini(max_targets, targets.size())
	for i in count:
		spawn_shot(targets[i])
		
func spawn_shot(target: Node2D):
	var current_projectile = projectile.instantiate()
	add_child(current_projectile)
	current_projectile.speed = projectile_speed
	current_projectile.damage = projectile_damage
	current_projectile.active = true
	active_projectiles.append({"node": current_projectile, "target": target})

func update_shots() -> void:
	for i in range(active_projectiles.size() - 1, -1, -1):
		var shot = active_projectiles[i]
		var node = shot["node"]
		var target = shot["target"]
		if not is_instance_valid(node):
			active_projectiles.remove_at(i)
		elif not is_instance_valid(target) or target not in targets:
			if is_instance_valid(node):
				node.queue_free()
			active_projectiles.remove_at(i)
		else:
			node.global_position = node.global_position.move_toward(target.global_position, projectile_speed)

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
	if body.is_in_group("Enemy") and body not in targets and is_in_group("Placed"):
		targets.append(body)

func _on_attack_bounds_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy") and body in targets and is_in_group("Placed"):
		targets.erase(body)



	
func get_upgradables() -> Array:
	var result := []
	var in_group := false
	for p in get_property_list():
		if p.usage & PROPERTY_USAGE_GROUP:
			in_group = (p.name == "Upgradables")
		elif in_group:
			result.append(p.name)
	return result
