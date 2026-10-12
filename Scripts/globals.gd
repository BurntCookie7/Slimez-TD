extends Node


var gold: int = 20
var placing: bool = false
var difficulty = 1
var map: PackedScene
var paused: bool
var volume: int

func _ready() -> void:
	Console.add_command("std_set_gold", change_gold, 1)
	
func change_gold(ammount: String):
	if not ammount.is_valid_int():
		Console.print_error("Usage: std_set_gold <number>")
		return
	gold = ammount.to_int()
	Console.print_line("Gold set to " + str(ammount))
