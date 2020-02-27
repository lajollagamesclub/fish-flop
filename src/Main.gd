extends Node2D

var dead: bool = false

func _ready():
	GameState.score = 0
	GameState.dead = false


func _on_Player_dead():
	GameState.dead = true
	$UI/DeathText.visible = true

func _input(event):
	if event is InputEventMouseButton and GameState.dead and event.pressed:
		get_tree().reload_current_scene()
