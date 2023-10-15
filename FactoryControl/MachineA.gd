class_name MachineA extends FactoryControl

func _process(_delta):
	# Retrieve all childnodes
	var west = get_node("West")
	var north = get_node("North")
	var east = get_node("East")
	var south = get_node("South")

	# If there is a connection show it
	west.set_visible(west_control != null)
	north.set_visible(north_control != null)
	east.set_visible(east_control != null)
	south.set_visible(south_control != null)
