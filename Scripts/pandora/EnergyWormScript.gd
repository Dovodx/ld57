extends CharacterBody2D

enum dir {
	UP, DOWN, LEFT, RIGHT
}
var current_direction = dir.UP
var speed = 150
var sections: Array[CharacterBody2D]
var next_position = global_position
var step_distance = 48
var xmax = 512 - 48
var xmin = 48
var ymax = 288 - 48
var ymin = 48

func _ready() -> void:
	pick_next_position()

func _physics_process(delta: float) -> void:
	if global_position.distance_squared_to(next_position) < 0.5:
		pick_next_position()
	velocity = (next_position - global_position).normalized() * speed
	move_and_slide()

func pick_next_position():
	var valid_dirs = dir.values()
	valid_dirs.erase(current_direction)
	
	if global_position.x <= xmin: valid_dirs.erase(dir.LEFT)
	if global_position.x >= xmax: valid_dirs.erase(dir.RIGHT)
	if global_position.y <= ymin: valid_dirs.erase(dir.UP)
	if global_position.y >= ymax: valid_dirs.erase(dir.DOWN)
	
	var i = randi_range(0, valid_dirs.size() - 1)
	current_direction = dir.values()[i]
	next_position = global_position + dir_enum_to_vector(current_direction) * step_distance
	print("global: " + str(global_position) + ", next: " + str(next_position))

func dir_enum_to_vector(direction):
	match direction:
		dir.UP: return Vector2.UP
		dir.DOWN: return Vector2.DOWN
		dir.LEFT: return Vector2.LEFT
		dir.RIGHT: return Vector2.RIGHT
	return Vector2.ZERO
