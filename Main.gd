class_name Main extends ColorRect

enum ActionType { Delete = 0, Pipe = 1, MachineA = 2 }

@export_group("FactoryControl Scene")
@export var pipe_scene: PackedScene
@export var machine_a_scene: PackedScene

func _ready():
	for action in ActionType:
		$ActionButton.add_item(action, ActionType[action])
	var index = $ActionButton.get_item_index(ActionType.Pipe)
	$ActionButton.select(index)
	_on_action_button_item_selected(index)

func _on_main_grid_control_created():
	var label = get_node("TestLabel")
	var s = get_tree().get_nodes_in_group("Controls").size()
	label.set_text("Control(s): " + str(s))

func _on_button_pressed():
	get_tree().call_group("Controls","queue_free")
	_on_main_grid_control_created()

func _on_action_button_item_selected(index):
	match $ActionButton.get_item_id(index):
		ActionType.Delete:
			$MainGrid.control_scene = null
		ActionType.Pipe:
			$MainGrid.control_scene = pipe_scene
		ActionType.MachineA:
			$MainGrid.control_scene = machine_a_scene
