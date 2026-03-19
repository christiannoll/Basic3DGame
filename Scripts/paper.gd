extends StaticBody3D

@export var paper_material: StandardMaterial3D
var toggle = false

func _ready() -> void:
	$MeshInstance3D.material_override = paper_material
