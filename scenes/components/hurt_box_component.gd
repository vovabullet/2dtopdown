extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent

func _on_area_entered(area: Area2D) -> void:
	# почему я не могу просто написать (area: HitBoxComponent) ?
	if not area is HitBoxComponent or not health_component: return
	
	var hit_box_component = area as HitBoxComponent
	health_component.take_damage(hit_box_component.damage)
