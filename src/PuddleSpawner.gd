extends Node2D
var last_puddle = null

func _ready():
	randomize()
	
	var cur_spawn_position: Vector2 = get_node("InitialPosition").global_position
	while cur_spawn_position.x < 5000.0:
		last_puddle = spawn_puddle(cur_spawn_position)
		cur_spawn_position = last_puddle.global_position

func on_puddle_despawned():
	var start_position = last_puddle.global_position
	last_puddle = spawn_puddle(start_position)

func spawn_puddle(initial_position: Vector2) -> Node2D:
	var new_position: Vector2 = initial_position + Vector2(rand_range(500, 800), 0.0)
	var cur_puddle: Node2D = preload("res://Puddle.tscn").instance()
	add_child(cur_puddle)
	cur_puddle.global_position = new_position
	cur_puddle.connect("despawning", self, "on_puddle_despawned")
	return cur_puddle
