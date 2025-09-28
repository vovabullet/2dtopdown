extends Node
class_name HealthComponent

signal died

@export var max_health = 10
var current_health

func _ready() -> void:
	current_health = max_health


func take_damage(dmg):
	current_health = max(current_health - dmg, 0) # чтоб не было ниже нуля
	# небольшая задержка чтобы убрать какую-то там ошибку. Стоит добавить в другую игру, там была похожая проблема.
	Callable(is_death).call_deferred()

func is_death():
	if !current_health:
		died.emit()
		owner.queue_free()
