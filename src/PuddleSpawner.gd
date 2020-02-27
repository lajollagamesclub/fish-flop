extends Node2D
var last_puddle = null

func _ready():
	randomize()
	
	var cur_spawn_position: Vector2 = get_node("InitialPosition").global_position
	spawn_puddle(cur_spawn_position)
	while cur_spawn_position.x < 5000.0:
		last_puddle = spawn_puddle_with_offset(cur_spawn_position)
		cur_spawn_position = last_puddle.global_position

func on_puddle_despawned():
	var start_position = last_puddle.global_position
	last_puddle = spawn_puddle_with_offset(start_position)

func spawn_puddle_with_offset(initial_position: Vector2) -> Node2D:
	var new_position: Vector2 = initial_position + Vector2(rand_range(400, 1300), 0.0)
	return spawn_puddle(new_position)

func spawn_puddle(target_position: Vector2) -> Node2D:
	var cur_puddle: Node2D = preload("res://Puddle.tscn").instance()
	add_child(cur_puddle)
	cur_puddle.global_position = target_position
	cur_puddle.global_position.y = get_node("../Floor").global_position.y
	cur_puddle.connect("despawning", self, "on_puddle_despawned")
	return cur_puddle
