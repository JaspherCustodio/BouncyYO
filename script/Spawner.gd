extends Node
class_name Spawner
signal player_crashed
signal point_scored

@export var obstacle_speed: int = -350
var obstacle_scene = preload("res://scene/obstacle.tscn")
@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.start()

func start_spawning_pipes():
	spawn_timer.timeout.connect(spawn_obstacle)

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate() as ObstaclePair
	add_child(obstacle)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	obstacle.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	obstacle.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	obstacle.player_entered.connect(on_body_entered)
	obstacle.player_scored.connect(on_player_scored)
	obstacle.set_speed(obstacle_speed)

func on_body_entered():
	player_crashed.emit()
	stop()

func stop():
	spawn_timer.stop()
	for obstacle in get_children().filter(func (child): return child is ObstaclePair):
		(obstacle as ObstaclePair).speed = 0

func on_player_scored():
	point_scored.emit()
