extends Control
@export var Placer: Node2D = null
@onready var upgraded_tower: Button = $VBoxContainer2/Control/UpgradedTower
@onready var basic_tower: Button = $VBoxContainer2/Control2/BasicTower
@onready var gold_label: Label = $NinePatchRect/GoldLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gold_label.text = str(Globals.gold)


func _on_upgraded_tower_pressed() -> void:
	if Globals.gold >= upgraded_tower.price:
		Globals.gold -= upgraded_tower.price
		Placer.set_tower(upgraded_tower.Tower)
		Globals.placing = true


func _on_basic_tower_pressed() -> void:
	if Globals.gold >= basic_tower.price:
		Globals.gold -= basic_tower.price
		Placer.set_tower(basic_tower.Tower)
		Globals.placing = true
