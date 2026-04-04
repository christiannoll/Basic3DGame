extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
		if get_tree().paused == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func resume():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func back_to_menu():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func quit_game():
	get_tree().quit()
