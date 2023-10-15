extends ColorRect

func _on_main_grid_pipe_created():
	var label = get_node("TestLabel")
	var s = get_tree().get_nodes_in_group("Pipes").size()
	label.set_text("Pipe created: " + str(s))

func _on_button_pressed():
	get_tree().call_group("Pipes","queue_free")
	_on_main_grid_pipe_created()
