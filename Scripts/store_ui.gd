extends Control
@export var map_parent: Node
@onready var map = map_parent.get_node("LoadedMap")
@export var Placer: Node2D = null
@onready var upgraded_tower: Button = $VBoxContainer2/Control/UpgradedTower
@onready var basic_tower: Button = $VBoxContainer2/Control2/BasicTower
@onready var gold_label: Label = $NinePatchRect/GoldLabel
@onready var round_display: Label = $RoundTitle/RoundNumber
@onready var health_display: Label = $NinePatchRect/HealthLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gold_label.text = str(Globals.gold)
	round_display.text = str(Globals.round)+"/"+str(map.rounds)
	health_display.text = str(Globals.player_health)

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


func _on_play_button_pressed() -> void:
	if not Globals.round_active:
		Globals.round_active = true
