extends Node

@export var exp_bottle_scene: PackedScene
@export var health_component: Node
@export var drop_chance = .5

func _ready() -> void:
	(health_component as HealthComponent).died.connect(_on_died) # ну и хуйня


func _on_died():
	if not exp_bottle_scene or not owner is Node2D: return
	if randf() < drop_chance: return
	
	var spawner_pos = (owner as Node2D).global_position
	var exp_bottle_instance = exp_bottle_scene.instantiate() as Node2D
	owner.get_parent().add_child(exp_bottle_instance)
	exp_bottle_instance.global_position = spawner_pos
