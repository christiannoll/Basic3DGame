extends StaticBody3D

var object_counter

func _ready() -> void:
	object_counter = get_tree().current_scene.get_node("UI/object_counter")

func interact():
	get_parent().num_of_objects += 1
	object_counter.text = str(get_parent().num_of_objects) + "/3"
	if get_parent().num_of_objects >= 3:
		pass
	queue_free()
