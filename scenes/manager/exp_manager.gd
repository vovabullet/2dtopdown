extends Node

# TODO переебать всё это в глобальную переменную
var current_exp = 0

func _ready() -> void:
	Global.exp_bottle_collected.connect(_on_exp_bottle_collected)

func _on_exp_bottle_collected(exp):
	current_exp += exp
