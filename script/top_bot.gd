extends Node2D
class_name Ground
signal player_crashed

@export var speed: int = 400
var screen_size: Vector2i
var scroll: int


func _ready() -> void:
	screen_size = get_window().size
	scroll = 960

func _process(delta: float) -> void:
	scroll += speed * delta
	if scroll >= screen_size.x:
		scroll = 960
	$BottomP.position.x = -scroll
	$TopP.position.x = -scroll

func _on_body_entered(body: Node2D) -> void:
	player_crashed.emit()
	stop()
	(body as Player).stop()

func stop():
	speed = 0
