extends Resource

signal moved(move_vector)

var position: Vector2 = Vector2()

func move(move_vector: Vector2) -> void:
	position -= move_vector
	emit_signal("moved", -move_vector)
