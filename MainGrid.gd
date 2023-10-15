extends ColorRect

@export var pipe_scene: PackedScene

signal pipe_created

var pressed_pipe: Pipe

func _input(_event):
	# we don't want the event that aren't for that scene
	var pos = get_viewport().get_mouse_position()
	if not get_rect().has_point(pos):
		return
	
	if Input.is_action_just_pressed("left_click"):
		pressed_pipe = get_pipe()
	if Input.is_action_just_released("left_click"):
		var released_pipe = get_pipe()
		if released_pipe == null:
			manage_placement()
		elif pressed_pipe && pressed_pipe != released_pipe:
			manage_connection(pressed_pipe, released_pipe)

func get_pipe() -> Pipe:
	var pos = get_local_mouse_position()
	var fact_x = factory_value(pos.x)
	var fact_y = factory_value(pos.y)
	var pipes = get_tree().get_nodes_in_group("Pipes")
	for pipe in pipes:
		if pipe.fact_x == fact_x && pipe.fact_y == fact_y:
			return pipe
	return null

func manage_connection(a: Pipe, b: Pipe):
	if a.fact_x == b.fact_x:
		if a.fact_y - b.fact_y == -1:
			a.south_pipe = b
			b.north_pipe = a
		elif a.fact_y - b.fact_y == 1:
			a.north_pipe = b
			b.south_pipe = a
	if a.fact_y == b.fact_y:
		if a.fact_x - b.fact_x == -1:
			a.east_pipe = b
			b.west_pipe = a
		elif a.fact_x - b.fact_x == 1:
			a.west_pipe = b
			b.east_pipe = a

func manage_placement():
	# verify if we don't have already a pipe here
	if get_pipe():
		return

	# create time
	var pipe = create_pipe()
	if pressed_pipe:
		manage_connection(pressed_pipe, pipe)

func create_pipe() -> Pipe:
	var pipe = pipe_scene.instantiate()

	var pos = get_local_mouse_position()
	pipe.fact_x = factory_value(pos.x)
	pipe.fact_y = factory_value(pos.y)

	pos.x = snap_value(pos.x)
	pos.y = snap_value(pos.y)
	pipe.position = pos 

	add_child(pipe)

	pipe_created.emit()

	return pipe

func factory_value(a: float) -> float:
	return floor(a / 50.0)

func snap_value(a: float) -> float:
	return floor(a / 50.0) * 50.0
