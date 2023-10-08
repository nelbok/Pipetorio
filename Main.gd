extends ColorRect

func _process(_delta):
	var label = get_node("TestLabel")
	
	if Input.is_action_just_pressed("left_click"):
		label.set_text("oirotepiP")
	if Input.is_action_just_released("left_click"):
		label.set_text("Pipetorio")
		
	#var position = get_viewport().get_mouse_position()
	#var test = grid.get_rect().has_point(position)
