extends Node2D

const player_state = preload("res://player_state.tres")

signal despawning

func _ready():
	randomize()
	var width: float = rand_range(150, 400)
	var new_shape = RectangleShape2D.new()
	new_shape.extents = $OKArea/CollisionShape2D.shape.extents
	$OKArea/CollisionShape2D.shape = new_shape
	$ColorRect.rect_size.x = width
	$ColorRect.rect_position.x = -width/2.0
	$OKArea/CollisionShape2D.shape.extents.x = width/2.0
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	global_position += move_vector

func _process(delta):
	if global_position.x <= -400.0:
		emit_signal("despawning")
		queue_free()


func _on_OKArea_body_entered(body):
	if body.is_in_group("player"):
		body.ok = true


func _on_OKArea_body_exited(body):
	if body.is_in_group("player"):
		body.ok = false
