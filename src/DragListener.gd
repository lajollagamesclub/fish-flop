extends Node2D

signal dragged(drag_vector)

var initial_drag_pos = null
var drag_vector: Vector2 = Vector2()

func _process(delta):
	if not Input.is_mouse_button_pressed(1):
		if initial_drag_pos != null:
			initial_drag_pos = null
			emit_signal("dragged", drag_vector)
	update()

func _input(event):
	if event is InputEventMouseMotion:
		if not Input.is_mouse_button_pressed(1):
			return
		# dragging the mouse
		if initial_drag_pos == null:
			initial_drag_pos = event.position

func _draw():
	if initial_drag_pos == null or GameState.dead:
		return
	drag_vector = -(get_viewport().get_mouse_position() - initial_drag_pos)
	draw_line(Vector2(), drag_vector, Color(0, 0, 0), 4.0)
