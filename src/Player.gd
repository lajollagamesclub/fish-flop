extends KinematicBody2D

signal dead

enum STATES {
	bouncing,
	flying,
	on_ground,
	dead
}

const player_state = preload("res://player_state.tres")

var accel: Vector2 = Vector2(0.0, 750.0)
var vel: Vector2 = Vector2(0.0, 0.0)
var state: int = STATES.flying
var ok: bool = false

func _ready():
	player_state.position = Vector2()

func _physics_process(delta):
	vel += accel*delta
	
	if state == STATES.on_ground:
		GameState.score -= 1.0
		if not ok:
			emit_signal("dead")
			state = STATES.dead
			set_physics_process(false)

	if move_and_collide(vel*delta, true, true, true) != null: # should mean on ground
		vel.y = 0.0
		vel.x = 0.0
		if state != STATES.on_ground:
			state = STATES.on_ground
			$AnimatedSprite.play("lying")
		
#	else:
#		if state != STATES.flying:
#			state = STATES.flying
#			$AnimatedSprite.play("flying")
	player_state.move(vel*delta)


func _on_DragListener_dragged(drag_vector):
	if state != STATES.on_ground:
		return
	state = STATES.flying
	$AnimatedSprite.play("flying")
	drag_vector.x = max(drag_vector.x, 0.0) # can't go to the left
	vel += drag_vector*1.3


func _on_PuddleFinder_area_entered(area):
	GameState.score += 500
