extends CharacterBody2D
class_name Player
signal game_started


@export var gravity: float = 890.0
@export var jump_force: int = 440
var max_speed: int = 500
var is_started: bool = false
var should_process_input: bool = true
var can_shoot = true
var bullet_direction = Vector2(1,0)
@onready var animation_player = $AnimationPlayer
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var hit_sound: AudioStreamPlayer2D = $HitSound


func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			game_started.emit()
			is_started = true
		jump()

	if !is_started:
		return
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed)
	move_and_collide(velocity * delta)

func jump():
	velocity.y = -jump_force
	animation_player.play("jump")
	jump_sound.play()

func kill():
	hit_sound.play()
	Global.camera.shake(0.2, 5)

func stop():
	velocity = Vector2.ZERO
