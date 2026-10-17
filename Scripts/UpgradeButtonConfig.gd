extends Control
@onready var button: Button = $HBoxContainer/Button
@onready var TitleLabel: Label = $HBoxContainer/Label
@onready var UpgradeNumberLabel: Label = $HBoxContainer/Label/Label
@onready var PriceLabel: Label = $HBoxContainer/Button/Price
@export var title: String = "Placeholder"
@export var max_upgrade: int = 10
@export var price: int = 5
var upgrade_step: int = 0
var tower = null
var tower_var = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TitleLabel.text = title
	UpgradeNumberLabel.text = str(upgrade_step)+"/"+str(max_upgrade)
	PriceLabel.text = "$"+str(price)


func _on_upgrade_pressed() -> void:
	upgrade_step += 1
	tower.set(tower_var, tower.get(tower_var) + 1)
	price += 3
