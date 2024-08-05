extends Node

const SAVE_FILE_PATH = "user://savedata.save"
var score = 0
var highscore = 0

@onready var player: CharacterBody2D = $"../Player" as Player
@onready var spawner: Node = $"../Spawner" as Spawner
@onready var top_bot: Node2D = $"../TopBot" as Ground
@onready var ui: CanvasLayer = $"../UI" as UI
@onready var audio_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"


func _ready() -> void:
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	audio_player.play()
	player.game_started.connect(on_game_started)
	top_bot.player_crashed.connect(end_game)
	spawner.player_crashed.connect(end_game)
	spawner.point_scored.connect(on_point_scored)
	load_highscore()

func on_game_started():
	ui.on_game_ready()
	ui.on_game_start()
	spawner.start_spawning_pipes()

func end_game():
	top_bot.stop()
	player.kill()
	spawner.stop()

	if score > highscore:
		highscore = score
		save_highscore()

	ui.on_game_over(score, highscore)
#
func on_point_scored():
	score += 1
	ui.update_points(score)

func set_score(new_score):
	score = new_score
	ui.on_game_over(score)
#
func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE_READ)
	save_data.store_32(highscore)

func load_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_FILE_PATH):
		highscore = save_data.get_32()

func _on_resetter_body_entered(body: Node2D) -> void:
	if body.name == "ObstaclePair":
		body.queue_free()

func _on_resetter_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.queue_free()
