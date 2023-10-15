extends ColorRect

@export var control_scene: PackedScene

signal control_created

var pressed_control: FactoryControl

func _input(_event):
	# FIXME: No PackedScene? Why?
	if not control_scene:
		return

	# we don't want the event that aren't for that scene
	var pos = get_viewport().get_mouse_position()
	if not get_rect().has_point(pos):
		return
	
	if Input.is_action_just_pressed("left_click"):
		pressed_control = get_control()
	if Input.is_action_just_released("left_click"):
		var released_control = get_control()
		if released_control == null:
			manage_placement()
		elif pressed_control && pressed_control != released_control:
			manage_connection(pressed_control, released_control)

func get_control() -> FactoryControl:
	var pos = get_local_mouse_position()
	var fact_x = factory_value(pos.x)
	var fact_y = factory_value(pos.y)
	var controls = get_tree().get_nodes_in_group("Controls")
	for control in controls:
		if control.fact_x == fact_x && control.fact_y == fact_y:
			return control
	return null

func manage_connection(a: FactoryControl, b: FactoryControl):
	if a.fact_x == b.fact_x:
		if a.fact_y - b.fact_y == -1:
			a.south_control = b
			b.north_control = a
		elif a.fact_y - b.fact_y == 1:
			a.north_control = b
			b.south_control = a
	if a.fact_y == b.fact_y:
		if a.fact_x - b.fact_x == -1:
			a.east_control = b
			b.west_control = a
		elif a.fact_x - b.fact_x == 1:
			a.west_control = b
			b.east_control = a

func manage_placement():
	# verify if we don't have already a control here
	if get_control():
		return

	# create time
	var control = create_control()
	if pressed_control:
		manage_connection(pressed_control, control)

func create_control() -> FactoryControl:
	var control = control_scene.instantiate()

	var pos = get_local_mouse_position()
	control.fact_x = factory_value(pos.x)
	control.fact_y = factory_value(pos.y)

	pos.x = snap_value(pos.x)
	pos.y = snap_value(pos.y)
	control.position = pos

	control.add_to_group("Controls")
	add_child(control)

	control_created.emit()

	return control

func factory_value(a: float) -> float:
	return floor(a / 50.0)

func snap_value(a: float) -> float:
	return floor(a / 50.0) * 50.0
