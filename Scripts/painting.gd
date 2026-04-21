extends StaticBody3D

@export var painting_mat: StandardMaterial3D

func _ready() -> void:
	$MeshInstance3D2.material_override = painting_mat
