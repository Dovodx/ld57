extends CharacterBody2D

var speed = 400

func _physics_process(delta: float):
	var input_dir = Vector2(Input.get_axis("left", "right"), Input.get_axis("forward", "back"))
	velocity = input_dir.normalized() * speed
	move_and_slide()
