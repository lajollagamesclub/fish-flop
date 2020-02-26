extends KinematicBody2D

enum STATES {
	bouncing,
	flying,
	on_ground
}

const player_state = preload("res://player_state.tres")

var accel: Vector2 = Vector2(0.0, 400.0)
var vel: Vector2 = Vector2(300.0, 0.0)
var state: int = STATES.flying

func _physics_process(delta):
	vel += accel*delta

	if move_and_collide(vel*delta, true, true, true) != null: # should mean on ground
		vel.y = 0.0
		state = STATES.on_ground
	else:
		state = STATES.flying
	player_state.move(vel*delta)
