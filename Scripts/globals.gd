extends Node

var default_gold: int = 30
var gold: int = default_gold
var placing: bool = false
var difficulty = 1
var map: PackedScene = load("res://Map1.tscn")
var paused: bool
var volume: int
var round: int
var round_active: bool = false
var default_player_health: int = 100
var player_health: int = default_player_health
signal tower_selected(tower)
signal tower_deselected 

func _ready() -> void:
	Console.add_command("std_set_gold", change_gold, 1)
	
func change_gold(ammount: String):
	if not ammount.is_valid_int():
		Console.print_error("Usage: std_set_gold <number>")
		return
	gold = ammount.to_int()
	Console.print_line("Gold set to " + str(ammount))
