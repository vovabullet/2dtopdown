# player.gd
extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# const потому что в будущем будет формула типа SPEED * speed_mult
const SPEED = 150
var movement_direction = Vector2.ZERO
var acceleration = 0.15

func _physics_process(delta: float) -> void:
	# поворот модельки
	if movement_direction.x != 0:
		animated_sprite_2d.flip_h = movement_direction.x < 0
	
	var target_velocity = movement_direction.normalized() * SPEED
	velocity = velocity.lerp(target_velocity, acceleration)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	movement_direction  = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
