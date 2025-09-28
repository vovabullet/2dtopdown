# enemy.gd
extends CharacterBody2D
class_name Enemy

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var health_component: Node = $HealthComponent

# Базовые характеристики (будут переопределены в дочерних классах)
# TODO надо ли это заосвывать в отдельные ресурсы?
#@export var health: int = 100
@export var speed: float = 50
@export var damage: int = 10
@export var attack_cooldown: float = 1.0

enum {IDLE, CHASE, ATTACK}
var state = CHASE
var target: CharacterBody2D = null
var can_attack: bool = true

func _ready() -> void:
	 # Ждем инициализации навигационной системы
	await get_tree().physics_frame
	
	target = get_tree().get_first_node_in_group("player")
	
	# Подключаемся к сигналу навигационного агента
	# TODO разобраться в этом
	navigation_agent.target_position = target.global_position if target else global_position

func _physics_process(delta: float) -> void:
	
	match state:
		IDLE: handle_idle_state()
		CHASE: handle_chase_state()
		ATTACK: handle_attack_state()
	
	update_animations()

func handle_idle_state():
	velocity = Vector2.ZERO
	if target:
		state = CHASE

func handle_chase_state():
	if not target:
		state = IDLE
		return
	navigation_agent.target_position = target.global_position
	# TODO разобраться в этом
	var next_position = navigation_agent.get_next_path_position()
	var direction = (next_position - global_position).normalized()

	velocity = direction * speed

# Проверяем расстояние до цели
	var distance_to_target = global_position.distance_to(target.global_position)
	# Если достаточно близко для атаки
	if distance_to_target < 50:  # Радиус атаки
		state = ATTACK
	else:
		# Продолжаем преследование
		move_and_slide()
		
		# Поворачиваем спрайт в направлении движения
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0

func handle_attack_state():
	if not target:
		state = IDLE
		return
	
	velocity = Vector2.ZERO
	
	# Проверяем расстояние до цели
	var distance_to_target = global_position.distance_to(target.global_position)
# Если цель ушла слишком далеко, возвращаемся к преследованию
	if distance_to_target > 70:  # Немного больше радиуса атаки
		state = CHASE
		return
	
	if can_attack:
		attack_target()

func attack_target():
	pass

func update_animations():
	animated_sprite.play("walk") if velocity else animated_sprite.play("idle")
