extends ColorRect

@export var pipe_scene: PackedScene

func _input(_event):
	# we don't want the event that aren't for that scene
	var position = get_viewport().get_mouse_position()
	if not get_rect().has_point(position):
		return
	
	if Input.is_action_just_pressed("left_click"):
		place_pipe()

func place_pipe():
	var pipe = pipe_scene.instantiate()
	var pos = get_local_mouse_position()
	pos.x = snap_value(pos.x)
	pos.y = snap_value(pos.y)
	pipe.position = pos 
	add_child(pipe)

func snap_value(a: float) -> float:
	return floor(a / 50.0) * 50.0
