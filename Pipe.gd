class_name Pipe extends Control

@export_group("Connections")
@export var west_pipe: Pipe
@export var north_pipe: Pipe
@export var east_pipe: Pipe
@export var south_pipe: Pipe

@export_group("Factory")
@export var fact_x: int
@export var fact_y: int

func _process(_delta):
	# Retrieve all childnodes
	var west = get_node("West")
	var north = get_node("North")
	var east = get_node("East")
	var south = get_node("South")
	
	# If there is a connection show it
	west.set_visible(west_pipe != null)
	north.set_visible(north_pipe != null)
	east.set_visible(east_pipe != null)
	south.set_visible(south_pipe != null)
