extends KinematicBody2D

const player_state = preload("res://player_state.tres")

func _ready():
	player_state.connect("moved", self, "_on_player_moved")

func _on_player_moved(move_vector: Vector2):
	move_vector.x = 0.0
	move_and_collide(move_vector)
