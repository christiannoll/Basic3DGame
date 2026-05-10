extends StaticBody3D

@export var light: Node3D
@export var light_off: StandardMaterial3D
@export var light_on: StandardMaterial3D
var toggle = false

func toggle_switch():
	toggle = !toggle
	if toggle == false:
		light.get_node("MeshInstance3D").material_override = light_off
	else:
		light.get_node("MeshInstance3D").material_override = light_on
	light.get_node("OmniLight3D").visible = toggle
