extends CanvasLayer
class_name UI

@onready var game_ready: VBoxContainer = $GameReady
@onready var game_over: VBoxContainer = $GameOver
@onready var high_score_label: Label = $GameOver/HighScoreLabel
@onready var score_label: Label = $GameOver/ScoreLabel
@onready var points_label: Label = $MarginContainer/PointsLabel
@onready var fade: Node = $Fade as Fade


func _ready() -> void:
	points_label.text ="%d" % 0

func on_game_ready():
	game_ready.visible = false

func on_game_start():
	points_label.visible = true

func update_points(points: int):
	points_label.text = "%d" % points

func on_game_over(score, highscore):
	if fade != null: 
		fade.play()
	score_label.text = "SCORE: %d" % score
	high_score_label.text = "BEST: %d" % highscore
	game_over.visible = true
	$GameOver/Panel/Restart.grab_focus()
	points_label.visible = false

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
