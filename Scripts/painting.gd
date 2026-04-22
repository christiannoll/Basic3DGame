extends StaticBody3D

@export var painting_mat: StandardMaterial3D
@export var scary_painting: StandardMaterial3D
@export var stare_time: float
@export var scare_time: float

func _ready() -> void:
	$MeshInstance3D2.material_override = painting_mat
	
func scare():
	await get_tree().create_timer(stare_time, false).timeout
	$jumpscare.play()
	$MeshInstance3D2.material_override = scary_painting
	await get_tree().create_timer(scare_time, false).timeout
	$jumpscare.stop()
	$MeshInstance3D2.material_override = painting_mat

func stop_scare():
	pass
