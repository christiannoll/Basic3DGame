extends SpotLight3D

var picked_up = false
var flashlight_ui
var flashlight_energy

func _ready() -> void:
	flashlight_ui = get_node("/root/" + get_tree().current_scene.name + "/UI/flashlight_stuff")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flashlight") && picked_up == true:
		visible = !visible
		$toggle.play()
