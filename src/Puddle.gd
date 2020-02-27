extends Node2D

const player_state = preload("res://player_state.tres")

signal despawning

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	global_position += move_vector

func _process(delta):
	if global_position.x <= -400.0:
		emit_signal("despawning")
		queue_free()
