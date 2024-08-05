extends Node2D
class_name ObstaclePair
signal player_entered
signal player_scored

var speed: int = 0

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func set_speed(new_speed):
	speed = new_speed

func _process(delta: float) -> void:
	position.x += speed * delta

func _on_body_entered(_body):
	player_entered.emit()

func _on_player_scored(_body):
	audio_player.play()
	player_scored.emit()
