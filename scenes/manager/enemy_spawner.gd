extends Node

@export var enemy_scene: PackedScene # пока что прикреплён орк



func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if !player: return
	
	# RIGHT - начало отчёта (справа от персонажа и далее по часовой стрелке)
	# TAU - 360 градусов
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(380, 500)
	var spawn_pos = player.global_position + (random_direction * random_distance) # TODO хз как целое число умножается на Vector2, надо потом узнать
	
	var enemy = enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	
	enemy.global_position = spawn_pos
