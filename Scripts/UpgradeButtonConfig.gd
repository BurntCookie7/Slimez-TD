@tool
extends Control
@onready var button: Button = $Button
@onready var TitleLabel: Label = $Label
@onready var UpgradeNumberLabel: Label = $Label/Label
@onready var PriceLabel: Label = $Button/Price
@export var Title: String
@export var max_upgrade: int = 10
@export var price: int = 5
var current_upgrade: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TitleLabel.text = Title
	UpgradeNumberLabel.text = str(current_upgrade)+"/"+str(max_upgrade)
	PriceLabel.text = "$"+str(price)


func _on_upgrade_pressed() -> void:
	current_upgrade += 1
	price += 3
