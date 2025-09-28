extends Node2D

var bottle_exp = 5


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.exp_bottle_collected.emit(bottle_exp)
	queue_free()
