extends Control
@onready var button: Button = $Button
@onready var TitleLabel: Label = $Button/Title
@onready var UpgradeNumberLabel: Label = $Button/StepCounter
@onready var PriceLabel: Label = $Button/Price
@export var title: String = "Placeholder"
@export var max_upgrade: int = 10
@export var price: int = 5
var upgrade_step: int
var tower = null
var tower_var = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_step = tower.upgrade_steps[tower_var]
	UpgradeNumberLabel.text = str(upgrade_step)+"/"+str(max_upgrade)
	

func get_upgrade_amount(stat: String):
	match stat:
		"attack_range":
			return 0.5
		"projectile_speed":
			return 0.2
		"projectile_damage":
			return 10
		"attack_cooldown":
			return 0.05

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TitleLabel.text = title
	PriceLabel.text = "Cost: $"+str(tower.upgrade_prices[tower_var])

func _on_upgrade_pressed() -> void:
	if upgrade_step >= max_upgrade:
		return
	else:
		if Globals.gold >= tower.upgrade_prices[tower_var]:
			tower.set(tower_var, tower.get(tower_var) + get_upgrade_amount(tower_var))
			tower.upgrade_steps[tower_var] += 1
			UpgradeNumberLabel.text = str(tower.upgrade_steps[tower_var])+"/"+str(max_upgrade)
			Globals.gold -= price
			tower.upgrade_prices[tower_var] += 1
		else:
			return
