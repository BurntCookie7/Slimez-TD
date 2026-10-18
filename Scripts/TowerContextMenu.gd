extends Control
@export var sell_price: int = 9
@export var upgrade_button_scene: PackedScene
@onready var container: VBoxContainer = $NinePatchRect/Control/VBoxContainer
var current_tower
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.tower_selected.connect(_on_tower_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sell_button_pressed() -> void:
	Globals.gold += sell_price
	current_tower.queue_free()
	hide()
	for child in container.get_children():
		child.queue_free()


func _on_exit_pressed() -> void:
	current_tower.radius_display.hide()
	hide()

func create_upgrade_button(title: String, price: int, variable, step: int, upgrade_price: int):
	var upgrade_button_instance = upgrade_button_scene.instantiate()
	upgrade_button_instance.title = str(title)
	upgrade_button_instance.tower = current_tower
	upgrade_button_instance.tower_var = variable
	upgrade_button_instance.upgrade_step = step
	upgrade_button_instance.price = upgrade_price
	container.add_child(upgrade_button_instance)

func first_upper(text: String):
	var specialized_text = text[0].to_upper() + text.substr(1)
	return specialized_text

func format_title(value: String):
	var split_title = value.split("_")
	var first_word = split_title[0]
	var second_word = split_title[1]
	var final_title = first_upper(first_word) + " " + first_upper(second_word)
	return final_title

func _on_tower_selected(tower):
	show()
	current_tower = tower
	for child in container.get_children():
		child.queue_free()
	for stat in tower.get_upgradables():
		var value = tower.get(stat)
		create_upgrade_button(format_title(stat), 10, stat, tower.upgrade_steps[stat], tower.upgrade_prices[stat])
		
		
